require 'urban_dictionary'

module Hipbot
  module Plugins
    class UrbanDictionary
      include Hipbot::Plugin

      desc 'explains a phrase using UrbanDictionary'
      on /^explain (.+)/ do |phrase|
        entry = ::UrbanDictionary.define(phrase)
        if entry.entries.nil? || entry.entries.empty?
          reply("Congrats #{sender.first_name}, you just invented a completely new #{phrase.count(' ').zero? ? 'word' : 'phrase'}.")
        else
          reply(entry.entries.first.definition)
        end
      end
    end
  end
end
