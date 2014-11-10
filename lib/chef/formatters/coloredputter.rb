require 'chef/formatters/base'
require 'rainbow'


class Chef
  module Formatters
    class Coloredputter < Outputter
      def initialize(out, err)
        super(out, err)
        if OS.windows?
          require 'Win32API'
          get_std_handle = Win32API.new("kernel32", "GetStdHandle", ['L'], 'L')
          @stdout = get_std_handle.call(-11)
          @set_console_txt_attrb = Win32API.new("kernel32", "SetConsoleTextAttribute", ['L','N'], 'I')
        end
      end

      def puts(string, *color)
        if OS.linux?
            case color[0]
              when 'green'
                @out.puts Rainbow(string).color(:green)
              when 'yellow'
                @out.puts Rainbow(string).color(:yellow)
              when 'red'
                @out.puts Rainbow(string).color(:red)
              when 'blue'
                @out.puts Rainbow(string).color(:blue)
              else
                @out.puts string
            end
        elsif OS.windows?
          case color[0]
            when 'green'
              @set_console_txt_attrb.call(@stdout, 90)
              @out.puts string
            when 'yellow'
              @set_console_txt_attrb.call(@stdout, 94)
              @out.puts string
            when 'red'
              @set_console_txt_attrb.call(@stdout, 92)
              @out.puts string
            when 'blue'
              @set_console_txt_attrb.call(@stdout, 91)
              @out.puts string
            else
              @set_console_txt_attrb.call(@stdout, 95)
              @out.puts string
          end
          @set_console_txt_attrb.call(@stdout, 95)
        else
          @out.puts string
        end
      end
    end
  end

  module OS
    def OS.windows?
      (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
    end

    def OS.mac?
      (/darwin/ =~ RUBY_PLATFORM) != nil
    end

    def OS.unix?
      !OS.windows?
    end

    def OS.linux?
      OS.unix? and not OS.mac?
    end
  end
end