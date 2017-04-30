module Partoo
  class Par2File
    class Packet
      class RecoverySlice < BinData::Record
        endian  :little
        uint32  :exponent

        array :recovery_data, :read_until => lambda { index == (body_length - 4) / 4 - 1 } do
          uint32  :recovery_chunk
        end
      end
    end
  end
end
