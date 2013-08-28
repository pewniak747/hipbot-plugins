require 'open-uri'

module Hipbot
  module Plugins
    class Excuses
      include Hipbot::Plugin

      desc 'provides you with an excuse'
      on /^excuse/ do
        excuse = Grabber.new.call
        reply(excuse)
      end

      class Grabber
        ADDRESS = 'http://developerexcuses.com/'

        def call
          data = page.match link_regexp
          data[1]
        end

        private

        def page
          @page ||= open(ADDRESS).read
        end

        def link_regexp
          /\<a href.+\>(.+)<\/a>/
        end
      end
    end
  end
end
