module Hipbot
  module Plugins
    class Github
      include Hipbot::Plugin

      desc 'links to two github branches comparision eg. `compare master to stable`'
      on /^compare (\w+)(?: to)? (\w+)$/, room: true do |stage1, stage2|
        reply "https://github.com/#{organization}/#{project.name}/compare/#{stage1}...#{stage2}" if project
      end

      desc 'links to production <-> staging comparision'
      on /^compare$/, room: true do
        reply "https://github.com/#{organization}/#{project.name}/compare/production...staging" if project
      end

      desc 'links to github code search in organization'
      on /^github (.+)/ do |query|
        query_hash = {
          q: "#{query} @#{organization}",
          ref: 'searchresults',
          type: 'Code',
          s: 'indexed'
        }
        reply "https://github.com/search?#{query_hash.to_query}"
      end
    end
  end
end
