require 'urban'

module Hipbot
  module Plugins
    class UrbanDictionary
      extend Hipbot::Plugin

      desc 'explains a phrase using UrbanDictionary'
      on /^explain (.+)/ do |phrase|
        entry = Urban::Dictionary.search(phrase)
        definition = entry.definitions.try(:first)
        reply(definition || "Congrats #{message.sender.first_name}, you just invented a completely new #{phrase.split.count > 1 ? 'phrase' : 'word'}.")
      end
    end
  end
end
