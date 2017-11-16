# frozen_string_literal: true
require 'erb'
require 'tilt'

module Handsaw
  module Filters
    class IndentedParagraph < HTML::Pipeline::Filter
      include ActionView::Helpers
      include ActionView::Context

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
          div.replace Nokogiri::HTML.fragment(compile)
        end

        (instance_variables - variables).each { |v| remove_instance_variable v }
        doc
      end

      def compile
        template
      end

      def template
        template_file_name = Dir.glob("app/processors/#{@context[:prefix]}/templates/#{@type}.*")[0]
        template = Tilt.new(template_file_name)
        template.render(self)
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
