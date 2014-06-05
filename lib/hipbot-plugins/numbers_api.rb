# encoding: utf-8

module Hipbot
  module Plugins
    class NumbersAPI
      include Hipbot::Plugin

      class NumbersTriviaGenerator
        URL = "http://numbersapi.com/"

        def date month, day
          get_trivia :date, day.present? ? "#{month}/#{day}" : month
        end

        def year year
          get_trivia :year, year
        end

        def math number
          get_trivia :math, number
        end

        def trivia number
          get_trivia :trivia, number
        end

        private

        def get_trivia type, number
          number = number.presence || 'random'

          open(URL + "#{number}/#{type}").read
        end
      end

      generator = NumbersTriviaGenerator.new

      desc "Random piece of number trivia for the specified number"
      on /^trivia(?: (\d+))?$/ do |number|
        reply generator.trivia(number)
      end

      desc "Random piece of information about the specified number"
      on /^trivia math(?: (\d+))?$/ do |number|
        reply generator.math(number)
      end

      desc "Random piece of information about the specified month and day"
      on /^trivia date(?: (\d{1,2}) (\d{1,2}))?$/ do |month, day|
        reply generator.date(month, day)
      end

      desc "Random piece of information about the specified year"
      on /^trivia year(?: (\d{4}))?$/ do |year|
        reply generator.year(year)
      end
    end
  end
end
