require 'redcarpet'

module Handsaw
  class Markdown < Redcarpet::Render::HTML
    include ActionView::Helpers::TextHelper
  end
end
