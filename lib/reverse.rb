require "reverse/version"

require 'socket'

class Reverse
  ADDR_REG_EXP = /\b((?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))\b/

  def initialize
    @list = {}
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
    line.gsub(ADDR_REG_EXP) do |addr|
      name = nil
      if @list[addr]
        name = @list[addr]
      else
        name = get_name(addr)
        @list[addr] = name
      end
      name
    end
  end

  def get_name(addr)
    info = Socket.getnameinfo(Socket.sockaddr_in('80', addr))
    info[0]
  end

end



