require "reverse/version"
require "socket"
require "term/ansicolor"
require "resolv"

class Reverse
  ADDR_REG_EXP = /\b((?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))\b/

  def initialize
    @resolv = Resolv::DNS.new(nameserver: ["8.8.8.8", "8.8.4.4"], ndots: 1)
    @list = {}
    Signal.trap(:INT){ exit(0) }
  end

  def exec
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
      color.green + name + color.clear
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
