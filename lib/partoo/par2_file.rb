require 'bindata'
require 'partoo/crc32'
require 'partoo/source_file'
require 'zlib'

module Partoo
  class Par2File < BinData::Record

    require 'partoo/par2_file/packet'

    array :packets, type: :packet, read_until: :eof

    def initialize_instance
      super
      @source_files = Hash.new
    end

    class << self
      def open(par2_file)
        io = File.open(par2_file)
        Par2File.read(io)
      end
    end

    def list
      file_ids.map do |id|
        f = source_file_by_id(id)
        { :name   => f.name,
          :md5    => f.md5,
          :length => f.size,
          :crc32  => f.crc32 }
      end
    end

    def to_md5
      file_ids.map do |id|
        f = source_file_by_id(id)
        f.md5.to_hex
          .concat('  ')
          .concat(f.name)
      end.join("\n").concat("\n")
    end

    def to_sfv
      file_ids.map do |id|
        f = source_file_by_id(id)
        f.name
          .concat(' ')
          .concat(f.crc32.to_s(16).rjust(8, '0'))
      end.join("\n").concat("\n")
    end

    def verify
      results = Hash.new
      file_ids.each do |id|
        f = source_file_by_id(id)
        block = Proc.new if block_given?
        results[f.name] = f.verify(&block)
      end
      results
    end

    def source_file_by_id(id)
      unless @source_files.key?(id)
        @source_files[id] = Partoo::Source_file.new(id,self)
      end
      @source_files[id]
    end

    def creator
      creator_packet['body']['creator']
    end

    def file_ids
      main_packet['body']['file_ids'].sort_by do |id|
        file_description_packet_by_id(id)['body']['file_name']
      end
    end

    def slice_size
      main_packet['body']['slice_size']
    end

    def recovery_set_file_count
      main_packet['body']['recovery_set_file_count']
    end

    def recovery_set_id
      main_packet['recovery_set_id']
    end

    def creator_packet
      packets.select do |p|
        p['packet_type'] == "PAR 2.0\0Creator\0"
      end.first
    end

    def file_description_packet_by_id(id)
      packets.select do |p|
        p['packet_type'] == "PAR 2.0\0FileDesc" && p['body']['file_id'] == id
      end.first
    end

    def input_file_slice_checksum_packet_by_id(id)
      packets.select do |p|
        p['packet_type'] == "PAR 2.0\0IFSC\0\0\0\0" && p['body']['file_id'] == id
      end.first
    end

    def main_packet
      packets.select do |p|
        p['packet_type'] == "PAR 2.0\0Main\0\0\0\0"
      end.first
    end
  end
end
