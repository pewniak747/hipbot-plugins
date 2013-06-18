module Hipbot
  module Plugins
    class Google
      extend Hipbot::Plugin

      desc 'returns first few results for Google search'
      on /^google (.+)/ do |search|
        get('http://ajax.googleapis.com/ajax/services/search/web', { q: URI::encode(search), safe: 'off', v: '1.0' }) do |http|
          http.json['responseData']['results'].each do |page|
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
          get('http://ajax.googleapis.com/ajax/services/search/web', { q: URI::encode(obj), safe: 'off', v: '1.0' }) do |http|
            score  = http.json['responseData']['cursor']['resultCount'].delete(' ').to_i
            winner = { name: obj, score: score } if score > winner[:score]
            left  -= 1
          end
        end
        sleep(1) until left == 0
        notify("...and the winner is #{winner[:name]}!", 'Google')
      end

      desc 'returns sample result of Google image search eg. `image trollface`'
      on /^image (.+)/ do |search|
        get('http://ajax.googleapis.com/ajax/services/search/images', { q: URI::encode(search), safe: 'moderate', v: '1.0', hl: 'pl', imgsz: 'large', rsz: 1 }) do |http|
          if http.json['responseData']['results'].present?
            reply http.json['responseData']['results'].sample['url']
          else
            reply "I found nothing, #{sender}"
          end
        end
      end

      desc 'returns sample result of YouTube search eg. `yt rick roll`'
      on /^youtube (.+)/, /^yt (.+)/ do |query|
        get('http://gdata.youtube.com/feeds/api/videos', { q: URI::encode(query), alt: 'json', :'max-results' => 3, orderBy: 'relevance'}) do |http|
          reply http.json['feed']['entry'].sample['link'][0]['href']
        end
      end

      desc 'translates text using Google Translate eg. `translate en:pl Hello world`'
      on /^translate (.+)/ do |query|
        params, text  = query.split(' ', 2)
        from, to      = params.split(':')
        if to.nil?
          to   = from
          from = 'pl'
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
