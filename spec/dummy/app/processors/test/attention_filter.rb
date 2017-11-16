# frozen_string_literal: true
class Test::AttentionFilter < Handsaw::Filters::IndentedParagraph
  def compile
    @text = 'hello'
    template
  end
end
