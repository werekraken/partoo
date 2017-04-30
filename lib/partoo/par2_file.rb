require 'bindata'

module Partoo
  class Par2File < BinData::Record

    require 'partoo/par2_file/packet'

    array :packets, type: :packet, read_until: :eof
  end
end
