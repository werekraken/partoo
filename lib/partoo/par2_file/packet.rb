require 'bindata'

module Partoo
  class Par2File
    class Packet < BinData::Record

      require 'partoo/par2_file/packet/creator'
      require 'partoo/par2_file/packet/input_file_slice_checksum'
      require 'partoo/par2_file/packet/file_description'
      require 'partoo/par2_file/packet/main'
      require 'partoo/par2_file/packet/recovery_slice'

      endian  :little
      string  :magic, :read_length => 8, :initial_value => "PAR2\0PKT"
      uint64  :packet_length
      uint128 :packet_md5
      uint128 :recovery_set_id
      string  :packet_type, :read_length => 16

      choice :body, :selection => :packet_type do
        creator                   "PAR 2.0\0Creator\0"
        input_file_slice_checksum "PAR 2.0\0IFSC\0\0\0\0"
        file_description          "PAR 2.0\0FileDesc"
        main                      "PAR 2.0\0Main\0\0\0\0"
        recovery_slice            "PAR 2.0\0RecvSlic"
      end

      def body_length
        packet_length - 64
      end
    end
  end
end
