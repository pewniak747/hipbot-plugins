module Hipbot
  module Plugins
    class Github < Hipbot::Plugin
      on /^compare (\w+)(?: to)? (\w+)$/, room: true do |stage1, stage2|
        reply "https://github.com/#{organization}/#{project.name}/compare/#{stage1}...#{stage2}" if project
      end

      on /^search (.+)/ do |query|
        query = URI::encode query
        reply "https://github.com/search?q=#{query}+%#{organization}&ref=searchresults&type=Code&s=indexed"
      end
    end
  end
end
