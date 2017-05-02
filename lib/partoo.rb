require 'partoo/par2_file'
require 'partoo/version'

module Partoo
  class << self

    # TODO: implement #create
    # TODO: implement #repair
    # TODO: implement #verify

    def dump(par2_file)
      io = File.open(par2_file)
      Par2File.read(io)
    end

    def list(par2_file)
      io = File.open(par2_file)
      f = Par2File.read(io)
      f.list
    end

    def creator(par2_file)
      io = File.open(par2_file)
      f = Par2File.read(io)
      f.creator
    end

    def recovery_set_file_count(par2_file)
      io = File.open(par2_file)
      f = Par2File.read(io)
      f.recovery_set_file_count
    end

    def recovery_set_id(par2_file)
      io = File.open(par2_file)
      f = Par2File.read(io)
      f.recovery_set_id
    end

    def slice_size(par2_file)
      io = File.open(par2_file)
      f = Par2File.read(io)
      f.slice_size
    end

    def to_md5(par2_file)
      io = File.open(par2_file)
      f = Par2File.read(io)
      f.to_md5
    end
  end
end
