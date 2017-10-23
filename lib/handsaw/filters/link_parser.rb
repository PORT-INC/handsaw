# frozen_string_literal: true
module Handsaw
  module Filters
    class LinkParser < HTML::Pipeline::Filter
      LINK_REG = /\A(\S+)[ \t\r\f]?:[ \t\r\f]?(\S+)[ \t\r\f]?\z/
      def call
        doc.search('a').each do |t|
          if attr = t.children.to_a.map(&:text).join('_').match(LINK_REG)
            t.replace Nokogiri::HTML.fragment(%(<a href="#{t['href']}"class="#{attr[1]}">#{attr[2]}</a>))
          end
        end
        doc
      end
    end
  end
end
