module Hipbot
  module Plugins
    class Google
      include Hipbot::Plugin

      desc 'returns first few results for Google search'
      on /^google (.+)/ do |search|
        get('http://ajax.googleapis.com/ajax/services/search/web', { q: search, safe: 'off', v: '1.0' }) do |http|
          results = http.json.fetch('responseData', {}).fetch('results', [])
          results.each do |page|
            reply("#{page['url']} - #{page['titleNoFormatting']}")
          end
        end
      end

      desc 'does an Google result count comparision eg. `firefox vs chrome vs ie`'
      on /^(.+ vs?\.? .+)/i do |battle|
        winner  = { score: 0 }
        objects = battle.split(/ vs?\.? /i)
        left    = objects.count
        objects.each do |obj|
          get('http://ajax.googleapis.com/ajax/services/search/web', { q: obj, safe: 'off', v: '1.0' }) do |http|
            resultCount = http.json.fetch('responseData', {}).fetch('cursor', {}).fetch('resultCount', 0)
            score  = resultCount.to_s.delete(' ').to_i
            winner = { name: obj, score: score } if score > winner[:score]
            left  -= 1
          end
        end
        sleep(1) until left == 0
        reply("...and the winner is #{winner[:name]}!")
      end

      desc 'returns sample result of Google image search eg. `image trollface`'
      on /^image (.+)/ do |search|
        get('http://ajax.googleapis.com/ajax/services/search/images', { q: search, safe: 'moderate', v: '1.0', hl: 'pl', imgsz: 'large', rsz: 1 }) do |http|
          results = http.json.fetch('responseData', {}).fetch('results', [])
          if results.any?
            reply results.sample['url']
          else
            reply "I found nothing, #{sender}"
          end
        end
      end

      desc 'returns sample result of YouTube search eg. `yt rick roll`'
      on /^youtube (.+)/, /^yt (.+)/ do |query|
        get('http://gdata.youtube.com/feeds/api/videos', { q: query, alt: 'json', :'max-results' => 3, orderBy: 'relevance' }) do |http|
          entry = http.json.fetch('feed', {}).fetch('entry', [])
          if entry.any?
            reply entry.sample['link'][0]['href']
          else
            reply "I found nothing, #{sender}"
          end
        end
      end

      desc 'translates text using Google Translate eg. `translate en:pl Hello world`'
      on /^translate (.+)/ do |query|
        params, text  = query.split(' ', 2)
        if text.nil?
          text = params
          from = 'auto'
          to   = 'en'
        else
          from, to = params.split(':')
          if to.nil?
            to   = from
            from = 'auto'
          end
        end

        params = {
            client: 't',
              text: text,
                hl: from,
                sl: 'auto',
                tl: to,
          multires: '1',
              prev: 'btn',
              ssel: '0',
              tsel: '4',
              uptl: to,
             alttl: from,
                sc: '1',
                ie: 'UTF-8',
                oe: 'UTF-8',
        }
        get('http://translate.google.com/translate_a/t', params) do |http|
          response = JSON.parse(http.body.gsub(/,+/, ','))
          reply(response[0][0][0])
        end
      end
    end
  end
end
