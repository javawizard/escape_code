require 'escape_code'

RSpec.describe EscapeCode do
  it 'handles pathological cases' do
    result = EscapeCode::HtmlFormatter.new("one \e[1mtwo\e[0m three \e[42;37mfour \e[1mfive \e[41msix\e[0m").generate
    expected = "one <span class='bold'>two</span> three <span class='white-foreground green-background'>four </span><span class='bold white-foreground green-background'>five </span><span class='bold white-foreground red-background'>six</span>"
    expect(result).to eq(expected)
  end

  it 'generates stylesheets that have both background and foreground colors' do
    stylesheet = EscapeCode::HtmlFormatter::ColorScheme.default.generate_stylesheet
    expect(stylesheet).to match(/ background-color:/)
    expect(stylesheet).to match(/ color:/)
  end

  it 'should probably have more specs'
end