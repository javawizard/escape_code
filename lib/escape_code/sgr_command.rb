
class EscapeCode::SgrCommand
  RESET = '0'
  BOLD = '1'

  COLORS = {
    0 => :black,
    1 => :red,
    2 => :green,
    3 => :yellow,
    4 => :blue,
    5 => :purple,
    6 => :cyan,
    7 => :white
  }

  attr_reader :type

  def initialize(type)
    @type = type
  end

  def reset?
    type == RESET
  end

  def bold?
    type == BOLD
  end

  def foreground_color?
    type =~ /^3[0-7]$/
  end

  def background_color?
    type =~ /^4[0-7]/
  end

  def color
    return nil unless foreground_color? || background_color?

    colors[type[1]]
  end
end
