module Hipbot
  module Plugins
    class MemeGenerator < Hipbot::Plugin
      on /^memes/ do
        reply(Generator.memes.keys.sort.join(', '))
      end

      on /^meme (\w+)\s+(.*)/ do |meme, text|
        generator = Generator.new(meme, text)
        query = {
          u: generator.image_url,
          tt: generator.upper_text,
          tb: generator.lower_text
        }
        image_url = "http://memecaptain.com/i?#{query.to_query}"
        reply(image_url)
      end

      class Generator
        attr_reader :upper_text, :lower_text, :meme
        def initialize meme, text
          @meme = meme
          assign_texts(text)
        end

        def image_url
          meme_name = self.class.memes.fetch(meme.to_s)
          "http://memecaptain.com/#{meme_name}.jpg"
        end

        private

        def assign_texts text
          quotes_regexp = /"(.*)"\s+"(.*)"/
          matches = text.match(quotes_regexp)
          if matches
            assign_upper_and_lower_texts(matches[1], matches[2])
          else
            middle = text.length / 2
            middle += 1 while !(text[middle].nil? || text[middle] =~ /\s/)
            assign_upper_and_lower_texts(text[0..middle], text[middle+1..-1])
          end
        end

        def assign_upper_and_lower_texts upper_text, lower_text
          @upper_text = upper_text.to_s.strip
          @lower_text = lower_text.to_s.strip
        end

        def self.memes
          {
            "yuno" => "y_u_no",
            "idontalways" => "most_interesting",
            "allthethings" => "all_the_things",
            "yodawg" => "xzibit",
            "toodamnhigh" => "too_damn_high",
            "fry" => "fry"
          }
        end
      end
    end
  end
end
