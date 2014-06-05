require 'dictionary-rb'

module Hipbot
  module Plugins
    class Dictionary
      include Hipbot::Plugin

      desc 'explains a phrase using UrbanDictionary'
      on /^explain (.+)$/ do |phrase|
        word = ::DictionaryRB::Word.new(phrase)

        if word.urban_meaning.present?
          reply(word.urban_meaning)
        elsif word.meaning.present?
          reply(word.meaning)
        else
          reply("Congrats #{sender.first_name}, you just invented a completely new phrase.")
        end

        if word.urban.examples.any?
          reply "Example: #{word.urban.examples.first}"
        elsif word.dictionary.examples.any?
          reply "Example: #{word.dictionary.examples.first}"
        end

        if word.urban.synonyms.any?
          reply "Synonyms: #{word.urban.synonyms.join(', ')}"
        end
      end
    end
  end
end
