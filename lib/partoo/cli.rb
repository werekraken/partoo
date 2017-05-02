require 'partoo'
require 'pp'
require 'thor'

module Partoo
  class CLI < Thor

    desc "dump <par2 file>", "Dump packets in a par2 file as a data structure"
    def dump(par2_file)
      pp Partoo.dump(par2_file)
    end

    desc "inspect <attribute> <par2 file>", "Inspect a particular attribute of a par2 file"
    long_desc <<-LONGDESC
    Inspect a particular attribute of a par2 file

    Attributes:
      creator
      recovery-set-file-count
      recovery-set-id
      slice-size
    LONGDESC
    def inspect(item, par2_file)
      attributes = ['creator', 'recovery-set-file-count', 'recovery-set-id', 'slice-size']
      raise ArgumentError, "#{item} is not one of #{attributes}" if ! attributes.include?(item)
      method = item.gsub(/-/, '_')
      if method == 'recovery_set_id'
        puts Partoo.send(method, par2_file).to_hex
      else
        puts Partoo.send(method, par2_file)
      end
    end

    desc "list <par2 file>", "Lists files described in a par2 file"
    def list(par2_file)
      Partoo.list(par2_file).each do |f|
        puts "#{f[0]['file_md5'].to_hex} #{f[1][:file_crc32].to_s(16).rjust(8, '0')} #{f[0]['file_length']} #{f[0]['file_name']}"
      end
    end

  end
end
