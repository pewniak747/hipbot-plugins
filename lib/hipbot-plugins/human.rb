require 'cleverbot'
require 'htmlentities'

module Hipbot
  module Plugins
    class Human
      extend Hipbot::Plugin

      on /^hello/ do
        reply("hello #{sender.first_name}!")
      end

      on /open the pod bay door[s]?/ do
        reply("I'm afraid I can't do that, #{sender.first_name}")
      end

      on /make me a (.+)/ do |thing|
        reply("/me hands #{sender} a #{thing}")
      end

      on /slap (.+)/ do
        message.mentions.each do |mention|
          reply("/me slaps #{mention} around a bit with a large trout.")
        end
      end

      on /insult (.+)/ do
        message.mentions.each do |mention|
          get('http://programmerinsults.com/') do |http|
            insult = http.body.scan(/color: #333;">(.+?)<\/a>/mi).flatten
            reply("#{mention}, #{insult.first}")
          end
        end
      end

      on /^choose( ([0-9]+))?/, room: true do |_, number|
        number ||= 1
        reply("/me chooses #{room.users.sample(number.to_i).map(&:name).to_sentence}") if room.present?
      end

      on /^(comfort|i haz a sad|i have a sad)/ do
        reply("/me pats #{message.sender.first_name} on the head")
        reply("#{message.sender.first_name}, everything is going to be alright!")
      end

      cleverbot = Cleverbot::Client.new
      default do |message|
        coder     = HTMLEntities.new
        reply(coder.decode(cleverbot.write(message)) || 'I don\'t undersand you')
      end
    end
  end
end
