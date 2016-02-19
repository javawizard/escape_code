
class EscapeCode::HtmlFormatter::ColorScheme
  def self.default
    @default ||= new(
      foreground: {
        black: '#2e3436',
        red: '#cc0000',
        green: '#4e9a06',
        yellow: '#c4a000',
        blue: '#3465a4',
        purple: '#75507b',
        cyan: '#06989a',
        white: '#d3d7cf'
      },
      background: {
        black: '#555753',
        red: '#ef2929',
        green: '#8ae234',
        yellow: '#fce94f',
        blue: '#729fcf',
        purple: '#ad7fa8',
        cyan: '#34e2e2',
        white: '#eeeeec'
      }
    )
  end

  def initialize(foreground:, background: nil)
    @foreground = foreground
    @background = background || foreground
  end

  def generate_stylesheet(prefix = '')
    stylesheet = []

    @background.each do |color, value|
      stylesheet << ".#{prefix}#{color}-background {\n  background-color: #{value};\n}"
    end

    @foreground.each do |color, value|
      stylesheet << ".#{prefix}#{color}-foreground {\n  background-color: #{value};\n}"
    end

    # TODO: Do this in a better way
    stylesheet << ".#{prefix}bold {\n  font-weight: bold;\n}"

    stylesheet.join("\n")
  end
end
