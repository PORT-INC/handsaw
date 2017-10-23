# frozen_string_literal: true
module Handsaw
  module Filters
    class CodeBlock < HTML::Pipeline::Filter
      include ActionView::Helpers

      def element_type
        self.class.to_s.split('::').last.underscore
      end

      def call
        variables = instance_variables
        doc.search('pre').each do |pre|
          next unless (codes = pre.at('code'))
          next unless (@type = codes.attributes.first&.last&.value) == element_type
          @value = pre.text
          pre.replace Nokogiri::HTML.fragment(template)
        end
        (instance_variables - variables).each { |v| remove_instance_variable v }
        doc
      end

      def template
        raise NotImplementedError
      end
    end
  end
end
