# frozen_string_literal: true
module Handsaw
  module Filters
    class BrParser < HTML::Pipeline::Filter
      def call
        doc.search('.//text()').each do |t|
          t.replace t.text.gsub(/\{br\}/, '') if t.text !~ /\A\s+\z/
        end
        doc
      end
    end
  end
end
