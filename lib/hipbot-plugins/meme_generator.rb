module Hipbot
  module Plugins
    class MemeGenerator < Hipbot::Plugin
      attr_accessor :username, :password

      def initialize(username, password)
        self.username = username
        self.password = password
      end

      on /^memes/ do
        reply(Generator.memes.keys.sort.join(', '))
      end

      on /^meme (\w+)\s+(.*)/ do |meme, text|
        generator = Generator.new(meme, text)
        query = {
          username: plugin.username,
          password: plugin.password,
          generatorID: generator.generator_id,
          imageID: generator.image_id,
          text0: generator.upper_text,
          text1: generator.lower_text
        }
        get('http://version1.api.memegenerator.net/Instance_Create', query) do |http|
          if http.json['success']
            image_url = http.json['result']['instanceImageUrl']
            reply(image_url)
          end
        end
      end

      class Generator
        attr_reader :upper_text, :lower_text, :generator_id, :image_id
        def initialize meme, text
          assign_texts(text)
          assign_generator(meme)
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

        def assign_generator meme
          @generator_id, @image_id = *self.class.memes.fetch(meme.to_sym, [2, 166088])
        end

        def self.memes
          {
            yuno: [2, 166088],
            idontalways: [74, 2485],
            allthethings: [6013, 1121885],
            yodawg: [79, 108785],
            orly: [920, 117049],
            toodamnhigh: [998, 203665],
            fry: [305, 84688],
            friday: [2003, 558116]
          }
        end
      end
    end
  end
end
