module Partoo
  class Par2File
    class Packet
      class Creator < BinData::Record
        endian  :little
        string  :creator, :read_length => :body_length, trim_padding: true
      end
    end
  end
end
