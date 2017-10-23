# frozen_string_literal: true
require 'cgi'

module Handsaw
  module Filters
    class DocParser < HTML::Pipeline::MarkdownFilter
      def call
        Nokogiri::HTML.fragment(
          @text.gsub(/^[ |　|\t]+$/, '').gsub(/```\S*\n[^`]+```\n/m) { |w| @context[:markdown_filter].render(w) } # rubocop:disable SymbolProc
               .split("\n\n").reduce([]) do |html, block|
                 html << parse(block.concat("\nEOS"))
               end.join("\n")
        )
      end

      def parse(text) # rubocop:disable all
        block_size = text.split("\n").size
        blocks = []
        inner_blocks = []
        key = nil
        level = 0
        text.each_line.with_index do |line, index|
          if key
            level = line.match(/^([ ]+).+$/).to_a[1].to_s.size if level.zero?
            if line.rstrip.match?(/^[ ]{#{level}}(\w+[ \t\r\f]?:[ \t\r\f]?.+)$/)
              hash_item = line.rstrip.match(/^[ ]{#{level}}(\w+[ \t\r\f]?:[ \t\r\f]?.+)$/).to_a[1]
              o_key, o_value = hash_item.split(':', 2).map(&:strip)
              inner_blocks << %(<div class="option">#{o_key}:#{o_value}</div>)
            else
              inner_blocks << line.rstrip.match(/^[ ]{#{level}}(.+)$/).to_a[1]
            end
            if !line.rstrip.match(/^[ ]{#{level}}.+$/) || block_size == index + 1
              blocks << %(<div class="#{key}">#{parse(inner_blocks.join("\n"))}</div>)
              inner_blocks = []
              level = 0
              key = line.rstrip.match(/^(\S+):$/).to_a[1]
            end
          elsif line.rstrip.match?(/^(\S+):$/)
            key = line.rstrip.match(/^(\S+):$/).to_a[1]
          else
            blocks << line.rstrip.match(/^[ ]{#{level}}(.+)$/).to_a[1] unless line =~ /^\s$/ || line == 'EOS'
          end
        end
        @context[:markdown_filter].render(blocks.join("\n")).strip
      end
    end
  end
end
