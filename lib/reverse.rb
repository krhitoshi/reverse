require "reverse/version"
require "socket"
require "term/ansicolor"
require "resolv"
require "optparse"

class Reverse
  ADDR_REG_EXP = /\b((?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))\b/

  def initialize
    @resolv = Resolv::DNS.new(nameserver: ["8.8.8.8", "8.8.4.4"], ndots: 1)
    @list = {}
    @options = {color: true}
    Signal.trap(:INT){ exit(0) }
  end

  def exec(argv)
    opt = OptionParser.new
    opt.on('--verbose',  'Verbose Mode (IP Address with reverse DNS)') {|v| @options[:verbose] = v }
    opt.on('--no-color',  'No Color Mode') {|v| @options[:color] = v }
    opt.parse!(argv)

    while line = gets
      output =
        if line =~ ADDR_REG_EXP
          replace_addr(line)
        else
          line
        end
      print output
    end
  end

  private

  def replace_addr(line)
    color = Term::ANSIColor
    line.gsub(ADDR_REG_EXP) do |addr|
      name = nil
      if @list[addr]
        name = @list[addr]
      else
        name = get_name(addr)
        @list[addr] = name
      end
      if @options[:verbose]
        str = "#{addr},#{name}"
      else
        str = name
      end
      if @options[:color]
        color.green + str + color.clear
      else
        str
      end
    end
  end

  def get_name(addr)
    begin
      @resolv.getname(addr).to_s
    rescue Resolv::ResolvError => e
      addr
    end
  end

end
