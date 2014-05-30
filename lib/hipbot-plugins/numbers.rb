require 'open-uri'

module Hipbot
  module Plugins
    class NumbersPlugin
      include Hipbot::Plugin

      desc "provides a random piece of number trivia"
      on /^numbers trivia$/ do 
        reply(NumbersTriviaGenerator.new("trivia").get_trivia)
      end

      desc "provides a random piece of math trivia"
      on /^numbers math$/ do
        reply(NumbersTriviaGenerator.new("math").get_trivia)
      end

      desc "provides a random piece of date trivia"
      on /^numbers date$/ do
        reply(NumbersTriviaGenerator.new("date").get_trivia)
      end

      desc "provides a random piece of year trivia"
      on /^numbers year$/ do
        reply(NumbersTriviaGenerator.new("year").get_trivia)
      end

      desc "provides a random piece of number trivia for the specified number"
      on /^numbers trivia (\d+)/ do |integer|
        reply(NumbersTriviaGenerator.new("trivia", integer).get_trivia)
      end

      desc "provides a random piece of information about the specified number"
      on /^numbers math (\d+)/ do |integer|
        reply(NumbersTriviaGenerator.new("math", integer).get_trivia)
      end

      desc "provides a random piece of information about the specified month and day"
      on /^numbers date (\d+) (\d+)/ do |month, day|
        reply(NumbersTriviaGenerator.new("date", month, day).get_trivia)
      end

      desc "provides a random piece of information about the specified year"
      on /^numbers year (\d+)/ do |year|
        reply(NumbersTriviaGenerator.new("year", year).get_trivia)
      end

      class NumbersTriviaGenerator
        URL = "http://numbersapi.com/"

        def initialize(type, number)
          @type = type
          @number = number
        end

        def initialize(type, month, day)
          @type = type
          @number = "#{month}/#{day}"
        end

        def initialize(type) 
          @type = type
          @number = "random"
        end
        
        def get_trivia
          open(URL + "#{@number}/#{@type}") { |f|
            return f.read
          }
        end
      end
    end
  end
end
