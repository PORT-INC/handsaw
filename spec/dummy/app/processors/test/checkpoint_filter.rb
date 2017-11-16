# frozen_string_literal: true
class Test::CheckpointFilter < Handsaw::Filters::IndentedParagraph
  def compile
    @text = 'hello'
    template
  end
end
