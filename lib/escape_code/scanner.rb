require 'strscan'

class EscapeCode::Scanner
  def initialize(string)
    @string = string
  end

  def scan(&block)
    enumerator = Enumerator.new do |y|
      scanner = StringScanner.new(@string)

      until scanner.eos?
        if scanner.scan EscapeCode::Code::REGEX
          y << EscapeCode::Code.parse(scanner.matched)
        else
          # TODO: don't split up strings with \e but not an actual escape sequence
          y << scanner.scan(/[^\e]*/)
        end
      end
    end

    if block
      enumerator.each(&block)
      nil
    else
      enumerator
    end
  end
end
