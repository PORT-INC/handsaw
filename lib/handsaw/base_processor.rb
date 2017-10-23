# frozen_string_literal: true

module Handsaw
  class BaseProcessor
    MARKDOWN_RENDERER = Redcarpet::Markdown.new(Handsaw::Markdown, tables: true, disable_indented_code_blocks: true, fenced_code_blocks: true)
    BEFORE_FILTERS = [
      Handsaw::Filters::DocParser,
    ].freeze

    AFTER_FILTERS = [
      Handsaw::Filters::BrParser,
      Handsaw::Filters::SpanParser,
      Handsaw::Filters::LinkParser,
      Handsaw::Filters::Sanitizer
    ].freeze

    attr_accessor :context

    def initialize(**context)
      @suffix = self.to_s.match(/(\w+)Processor/).to_a[1]&.underscore
      @each_filters = Dir.glob('app/processors/' + @suffix + '/*.rb').map do |path|
      	name = File::basename(path).sub(File::extname(path), '')
      	Object.const_get "#{@suffix.camelize}::#{name.camelize}"
      end if @suffix
      @context = context.merge(suffix: @suffix, markdown_filter: (context[:markdown_filter] || MARKDOWN_RENDERER))
    end

    def render(text, **context)
      pipe = HTML::Pipeline.new(filters, @context)
      pipe.call(text, **context)[:output]
    end

    def filters
      @filters ||= BEFORE_FILTERS + @each_filters + AFTER_FILTERS
    end
  end
end
