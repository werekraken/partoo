require 'bindata'
require 'partoo/crc32'
require 'zlib'

module Partoo
  class Par2File < BinData::Record

    require 'partoo/par2_file/packet'

    array :packets, type: :packet, read_until: :eof

    def list
      file_ids.map do |id|
        [file_description_packet_by_id(id)[0]['body'], {:file_crc32 => crc32_by_id(id)}]
      end
    end

    def to_md5
      file_ids.sort_by do |id|
        file_description_packet_by_id(id)[0]['body']['file_name']
      end.map do |id|
        file_description_packet_by_id(id)[0]['body']['file_md5'].to_hex
          .concat('  ')
          .concat(file_description_packet_by_id(id)[0]['body']['file_name'])
      end.join("\n").concat("\n")
    end

    def to_sfv
      file_ids.sort_by do |id|
        file_description_packet_by_id(id)[0]['body']['file_name']
      end.map do |id|
        file_description_packet_by_id(id)[0]['body']['file_name']
          .concat(' ')
          .concat(crc32_by_id(id).to_s(16).rjust(8, '0'))
      end.join("\n").concat("\n")
    end

    def crc32_by_id(id)
      crc = ""
      input_file_slice_checksum_packet_by_id(id)[0]['body']['chunk_checksums'].each do |cc|
        crc_b = cc['crc32']
        if crc != ""
          crc = Zlib.crc32_combine(crc, crc_b, slice_size)
        else
          crc = crc_b
        end
      end
      pad_length = slice_size - file_description_packet_by_id(id)[0]['body'].file_length % slice_size
      crc_z = Zlib.crc32("\0" * pad_length)
      Partoo::CRC32.crc32_trim_trailing(crc, crc_z, pad_length)
    end

    def creator
      creator_packet[0]['body']['creator']
    end

    def file_ids
      main_packet[0]['body']['file_ids']
    end

    def slice_size
      main_packet[0]['body']['slice_size']
    end

    def recovery_set_file_count
      main_packet[0]['body']['recovery_set_file_count']
    end

    def recovery_set_id
      main_packet[0]['recovery_set_id']
    end

    def creator_packet
      packets.select {|p| p['packet_type'] == "PAR 2.0\0Creator\0" }
    end

    def file_description_packet_by_id(id)
      packets.select {|p| p['packet_type'] == "PAR 2.0\0FileDesc" && p['body']['file_id'] == id }
    end

    def input_file_slice_checksum_packet_by_id(id)
      packets.select {|p| p['packet_type'] == "PAR 2.0\0IFSC\0\0\0\0" && p['body']['file_id'] == id }
    end

    def main_packet
      packets.select {|p| p['packet_type'] == "PAR 2.0\0Main\0\0\0\0" }
    end
  end
end
