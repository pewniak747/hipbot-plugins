require "hipbot"
require "hipbot-plugins/version"
require "hipbot-plugins/ascii"
require "hipbot-plugins/excuses"
require "hipbot-plugins/help"
require "hipbot-plugins/human"
require "hipbot-plugins/github"
require "hipbot-plugins/google"
require "hipbot-plugins/numbers"
require "hipbot-plugins/wolfram_alpha"
require "hipbot-plugins/meme_generator"
require "hipbot-plugins/rapportive"

module Hipbot
  module Plugins
      desc 'list available memes to generate'
      on /^memes/ do
        reply(Generator.memes.keys.sort.join(', '))
      end
  end
end
