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
    option :crc32, :aliases => "-c", :type => :boolean, :desc => "Include file crc32 in the output"
    option :long,  :aliases => "-l", :type => :boolean, :desc => "Equivalent to --crc32 --md5 --size"
    option :md5,   :aliases => "-m", :type => :boolean, :desc => "Include file md5 in the output"
    option :size,  :aliases => "-s", :type => :boolean, :desc => "Include file size in the output"
    def list(par2_file)
      l = Partoo.list(par2_file)
      size_print_width = l.map do |f|
        f[:length].to_s.length
      end.max
      l.each do |f|
        print "#{f[:crc32].to_s(16).rjust(8, '0')} "             if options[:crc32] or options[:long]
        print "#{f[:md5].to_hex} "                               if options[:md5]   or options[:long]
        print "#{f[:length].to_s.rjust(size_print_width, ' ')} " if options[:size]  or options[:long]
        puts  "#{f[:name]}"
      end
    end

    desc "tomd5 <par2 file>", "Build an md5 file from par2 file data"
    def tomd5(par2_file)
      puts Partoo.to_md5(par2_file)
    end

    desc "tosfv <par2 file>", "Build an sfv file from par2 file data"
    def tosfv(par2_file)
      puts Partoo.to_sfv(par2_file)
    end

    desc "verify <par2 file>", "Verify source files found in a par2 file"
    def verify(par2_file)
      Partoo.verify(par2_file).each do |file,result|
        puts "#{file} #{result}"
      end
    end
  end
end
