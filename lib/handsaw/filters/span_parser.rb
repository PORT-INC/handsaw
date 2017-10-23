# frozen_string_literal: true
module Handsaw
  module Filters
    class SpanParser < HTML::Pipeline::Filter
      SPAN_REG = /\{[ \t\r\f]?(\w+)[ \t\r\f]?:[ \t\r\f]?(\S+)[ \t\r\f]?\}/
      def call
        doc.search('.//text()').each do |t|
          if t.text !~ /\A\s+\z/
            t.replace t.text.gsub(SPAN_REG, '<span class="\1">\2</span>')
            t.replace t.text.gsub(/^{br}.*/, '')
          end
        end
        doc
      end
    end
  end
end
