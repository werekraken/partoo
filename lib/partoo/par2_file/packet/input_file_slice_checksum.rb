module Partoo
  class Par2File
    class Packet
      class InputFileSliceChecksum < BinData::Record
        endian  :little
        uint128 :file_id

        array :chunk_checksums, :read_until => lambda { index == (body_length - 16) / 20 - 1 } do
          uint128 :md5
          uint32  :crc32
        end
      end
    end
  end
end
