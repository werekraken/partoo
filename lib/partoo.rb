require 'partoo/par2_file'
require 'partoo/version'

module Partoo
  class << self

    # TODO: implement #create
    # TODO: implement #repair
    # TODO: implement #verify

    def list(par2_file)
      "list of files from #{par2_file}"
    end

    def dump(par2_file)
      io = File.open(par2_file)
      Par2File.read(io)
    end
  end
end
