require 'cgi'

class EscapeCode::HtmlFormatter
  def initialize(text, prefix = '', color_scheme: EscapeCode::HtmlFormatter::ColorScheme.default)
    @prefix = prefix
    @color_scheme = color_scheme
    @scanner = EscapeCode::Scanner.new(text)
  end

  def generate_stylesheet
    @color_scheme.generate_stylesheet
  end

  def generate
    state = EscapeCode::SgrState.new

    @scanner.scan.map do |thing|
      case thing
      when EscapeCode::Code
        state.ingest(thing)
      when String
        classes = compute_classes(state)
        if classes.empty?
          CGI.escapeHTML(thing)
        else
          "<span class='#{compute_classes(state)}'>#{CGI.escapeHTML(thing)}</span>"
        end
      end
    end.compact.join
  end

  def generate_page
    "<html><head><style>#{generate_stylesheet}</style></head><body><pre>#{generate}</pre></body></html>"
  end

  private def compute_classes(state)
    classes = []
    classes << 'bold' if state.bold?
    classes << "#{@prefix}#{state.foreground}-foreground" if state.foreground
    classes << "#{@prefix}#{state.background}-background" if state.background
    classes.join(' ')
  end
end
