# frozen_string_literal: true
module Handsaw
  module Filters
    class Sanitizer < HTML::Pipeline::Filter
      def call
        doc.to_s
      end
    end
  end
end
