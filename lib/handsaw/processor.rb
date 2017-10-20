# frozen_string_literal: true
module Handsaw
  class Processor
    DEFAULT_FILTERS = [
    ].freeze

    attr_accessor :context
    def initialize(**context)
      @context = context
    end

    def render(text, **context)
      pipe = HTML::Pipeline.new(filters, @context)
      pipe.call(text, **context)[:output]
    end

    def filters
      @filters ||= DEFAULT_FILTERS
    end
  end
end
