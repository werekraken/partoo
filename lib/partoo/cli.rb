require 'partoo'
require 'thor'

module Partoo
  class CLI < Thor

    desc "list FILE", "Lists files in par2 FILE"
    def list(par2_file)
      puts Partoo.list(par2_file)
    end

  end
end
