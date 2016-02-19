
class EscapeCode::SgrState
  attr_reader :bold, :foreground, :background
  alias_method :bold?, :bold

  def initialize
    @bold = false
    @foreground = nil
    @background = nil
  end

  def ingest(command)
    # convenience thing to allow passing in an entire code instead of individual SGR commands
    if command.is_a?(EscapeCode::Code)
      command.sgr_commands.each { |c| ingest(c) } if command.sgr?
      return
    end

    if command.reset?
      @bold = false
      @foreground = nil
      @background = nil
    elsif command.bold?
      @bold = true
    elsif command.foreground_color?
      @foreground = command.color
    elsif command.background_color?
      @background = command.color
    end
  end
end
