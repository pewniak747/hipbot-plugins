module Hipbot
  module Plugins
    class Github
      extend Hipbot::Plugin

      desc 'links to two github branches comparision eg. `compare master to stable`'
      on /^compare (\w+)(?: to)? (\w+)$/, room: true do |stage1, stage2|
        reply "https://github.com/#{organization}/#{project.name}/compare/#{stage1}...#{stage2}" if project
      end

      desc 'links to github code search in organization'
      on /^github (.+)/ do |query|
        query = URI::encode query
        reply "https://github.com/search?q=#{query}+%40#{organization}&ref=searchresults&type=Code&s=indexed"
      end
    end
  end
end
