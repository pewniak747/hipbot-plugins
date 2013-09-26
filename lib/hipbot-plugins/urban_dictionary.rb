require 'urban'

module Hipbot
  module Plugins
    class UrbanDictionary
      include Hipbot::Plugin

      desc 'explains a phrase using UrbanDictionary'
      on /^explain (.+)/ do |phrase|
        entry = Urban::Dictionary.search(phrase)
        if entry.definitions.nil? || entry.definitions.empty?
          reply("Congrats #{sender.first_name}, you just invented a completely new #{phrase.count(' ').zero? ? 'word' : 'phrase'}.")
        else
          reply(entry.definitions.first)
        end
      end
    end
  end
end
