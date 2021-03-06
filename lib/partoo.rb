require 'partoo/par2_file'
require 'partoo/version'

module Partoo
  class << self

    # TODO: implement .create
    # TODO: implement .repair

    def dump(par2_file)
      Par2File.open(par2_file)
    end

    def list(par2_file)
      f = Par2File.open(par2_file)
      f.list
    end

    def creator(par2_file)
      f = Par2File.open(par2_file)
      f.creator
    end

    def recovery_set_file_count(par2_file)
      f = Par2File.open(par2_file)
      f.recovery_set_file_count
    end

    def recovery_set_id(par2_file)
      f = Par2File.open(par2_file)
      f.recovery_set_id
    end

    def slice_size(par2_file)
      f = Par2File.open(par2_file)
      f.slice_size
    end

    def to_md5(par2_file)
      f = Par2File.open(par2_file)
      f.to_md5
    end

    def to_sfv(par2_file)
      f = Par2File.open(par2_file)
      f.to_sfv
    end

    def verify(par2_file)
      f = Par2File.open(par2_file)
      block = Proc.new if block_given?
      f.verify(&block)
    end
  end
end
