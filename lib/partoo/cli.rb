require 'partoo'
require 'pp'
require 'thor'

module Partoo
  class CLI < Thor

    desc "list FILE", "Lists files in par2 FILE"
    def list(par2_file)
      puts Partoo.list(par2_file)
    end

    desc "dump FILE", "Dump packets in par2 FILE"
    def dump(par2_file)
      pp Partoo.dump(par2_file)
    end
  end
end
