require 'digest'
require 'partoo/crc32'

module Partoo
  class Source_file

    def initialize(id, par2_file_object)
      @id = id
      @par2 = par2_file_object
      @crc32 = nil
      @real_size = nil
    end

    def name
      @par2.file_description_packet_by_id(@id)['body']['file_name']
    end

    def crc32
      if @crc32.nil?
        @par2.input_file_slice_checksum_packet_by_id(@id)['body']['chunk_checksums'].each do |cc|
          crc_b = cc['crc32']
          if @crc32.nil?
            @crc32 = crc_b
          else
            @crc32 = Zlib.crc32_combine(@crc32, crc_b, @par2.slice_size)
          end
        end
        pad_length = @par2.slice_size - @par2.file_description_packet_by_id(@id)['body'].file_length % @par2.slice_size
        crc_z = Zlib.crc32("\0" * pad_length)
        @crc32 = Partoo::CRC32.crc32_trim_trailing(@crc32, crc_z, pad_length)
      end
      @crc32
    end

    def size
      @par2.file_description_packet_by_id(@id)['body']['file_length']
    end

    def md5
      @par2.file_description_packet_by_id(@id)['body']['file_md5']
    end

    def verify
      chunk_size = 32768
      real_crc32 = Partoo::CRC32.new
      real_md5 = Digest::MD5.new
      File.open(name, 'rb') do |f|
        until f.eof?
          chunk = f.read(chunk_size)
          real_crc32.update(chunk)
          real_md5.update(chunk)
        end
      end
      real_crc32.hexdigest == crc32.to_s(16).rjust(8, '0') && real_md5.hexdigest == md5.to_hex
    end

    def real_size
      if @real_size.nil?
        @real_size = File.size?(name)
      end
      @real_size
    end

    def is_truncated?
      real_size > size
    end

    def is_oversized?
      real_size < size
    end
  end
end
