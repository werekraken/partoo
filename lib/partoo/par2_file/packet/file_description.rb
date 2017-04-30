module Partoo
  class Par2File
    class Packet
      class FileDescription < BinData::Record
        endian  :little
        uint128 :file_id
        uint128 :file_md5
        uint128 :file_md5_16k
        uint64  :file_length
        string  :file_name, :read_length => lambda { body_length - 56 }, trim_padding: true
      end
    end
  end
end
