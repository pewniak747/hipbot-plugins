require 'wolfram'

module Hipbot
  module Plugins
    class WolframAlpha
      include Hipbot::Plugin

      delegate :appid=, to: :Wolfram

      desc 'returns first three WolframAlpha search results'
      on /^wolfram (.+)/ do |query|
        result = Wolfram.fetch(query)
        result.pods[1..3].each do |pod|
          if pod.plaintext.present?
            text = pod.plaintext
          elsif pod.img.attributes['src'].value.present?
            text = pod.img.attributes['src'].value + "#.jpg"
          else
            next
          end
          reply("#{pod.title}: #{text}")
        end
      end
    end
  end
end
