
class EscapeCode::Code
  REGEX = /\e\[([0-9;]*)([a-zA-Z])/

  SGR = 'm'

  # TODO: Support other types of escape codes, like private sequences and non-alphanumeric mode characters
  attr_reader :type, :args, :sgr_commands

  def initialize(type, args)
    @type = type
    @args = args

    if sgr?
      @sgr_commands ||= begin
        if args == []
          # SGR without an argument is equvalent to reset
          [EscapeCode::SgrCommand.new(SgrCommand::RESET)]
        else
          args.map do |arg|
            EscapeCode::SgrCommand.new(arg)
          end
        end
      end
    end
  end

  def self.parse(code)
    raise 'not a valid escape sequence' unless code =~ REGEX
    new($~[2], $~[1].split(';'))
  end

  def sgr?
    type == SGR
  end
end
