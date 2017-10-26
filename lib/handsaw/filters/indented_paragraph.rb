# frozen_string_literal: true
require 'erb'

module Handsaw
  module Filters
    class IndentedParagraph < HTML::Pipeline::Filter
      include ActionView::Helpers

      def element_type
        self.class.to_s.split('::').last.match(/(\w+)Filter/).to_a[1]&.underscore
      end

      def call
        variables = instance_variables
        doc.search('div').each do |div|
          @type = div.attributes['class']&.value
          next unless @type == element_type
          values = []
          div.children.each do |item|
            if item.attributes['class']&.value == 'option'
              define_variable item
              item.replace ''
            elsif item.text != "\n"
              values << item.to_s
            end
          end
          @value = values.join.gsub(/^\s*$/, '')
          div.replace Nokogiri::HTML.fragment(template)
        end

        (instance_variables - variables).each { |v| remove_instance_variable v }
        doc
      end

      def template
        open("app/processors/#{@context[:suffix]}/templates/#{@type}.html.erb") do |f|
          ERB.new(f.read).result(binding)
        end
      end

      def define_variable(item)
        item.text.each_line do |line|
          if hash_item = line.strip.match(/^(.+:.+)$/).to_a[1]
            key, value = hash_item.split(':', 2).map(&:strip)
            instance_variable_set("@#{key}", value)
          end
        end
      end
    end
  end
end
