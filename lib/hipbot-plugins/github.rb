module Hipbot
  module Plugins
    class Github < Hipbot::Plugin
      on /^compare (\w+)(?: to)? (\w+)$/, room: true do |stage1, stage2|
        reply "https://github.com/#{organization}/#{project.name}/compare/#{stage1}...#{stage2}" if project
      end

      on /^github (.+)/ do |query|
        query = URI::encode query
        reply "https://github.com/search?q=#{query}+%40#{organization}&ref=searchresults&type=Code&s=indexed"
      end
    end
  end
end
