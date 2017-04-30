module Partoo
  class Par2File
    class Packet
      class Main < BinData::Record
        endian  :little
        uint64  :slice_size
        uint32  :recovery_set_file_count

        # TODO: need to split recovery set id and non-recovery set id arrays
        #
        #   this works for recovery
        #     array :recovery_set_file_ids, :read_until => lambda { index == recovery_set_file_count - 1 } do
        #
        #   this doesn't error, but causes no additional packets to be parsed
        #     array :non_recovery_set_file_ids, :read_until => lambda { index == (body_length - 8 - 4) / 16 - 1 - recovery_set_file_count } do
        #
        array :file_ids, :read_until => lambda { index == (body_length - 8 - 4) / 16 - 1 } do
          uint128 :md5
        end
      end
    end
  end
end
