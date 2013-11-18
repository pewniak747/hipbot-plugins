module Hipbot
  module Plugins
    class Help
      include Hipbot::Plugin

      desc 'lists all standard emoticons'
      on /^emoticons/ do
        reply ":-) :o :$ :( :-* :# :'( ;-) (embarrassed) :Z :p 8) O:) :-D (oops) :| (thumbsup) (thumbsdown) (allthethings) (android) (areyoukiddingme)" +
              " (arrington) (ashton) (awyeah) (badpokerface) (basket) (beer) (bumble) (bunny) (cadbury) (cake) (candycorn) (caruso) (cereal)" +
              " (challengeaccepted) (chewie) (chocobunny) (chompy) (chris) (coffee) (content) (cornelius) (dealwithit) (derp)" +
              " (disapproval) (dosequis) (ducreux) (dumb) (facepalm) (fap) (foreveralone) (freddie) (fry) (fu) (fuckyeah) (garret) (gates) (ghost) (goodnews)"
        # splitted for better formatting under Adobe AIR clients
        reply "(greenbeer) (gtfo) (haveaseat) (heart) (hipchat) (hipster) (huh) (ilied) (itsatrap) (jackie) (jobs) (kennypowers) (krang) (kwanzaa) (lincoln)" +
              " (lol) (lolwut) (megusta) (menorah) (notbad) (nothingtodohere) (ohcrap) (okay) (omg) (orly) (pbr) (pete) (philosoraptor) (pirate) (pokerface)" +
              " (poo) (present) (pumpkin) (rageguy) (rebeccablack) (reddit) (rudolph) (sadpanda) (sadtroll) (samuel) (santa) (scumbag) (seomoz) (shamrock)" +
              " (skyrim) (stare) (sweetjesus) (taft) (tree) (troll) (truestory) (turkey) (washington) (wat) (wtf) (yey) (yodawg) (yuno) (zoidberg) (zzz)"
      end

      desc 'generates help for all reactions'
      on /^help$/ do
        reactions_with_description = Hipbot.reactions.reject{ |reaction| reaction.desc.nil? }
        help = reactions_with_description.map do |reaction|
          "#{reaction.plugin_name}: #{reaction.readable_command} - #{reaction.desc}"
        end
        reply help.join("\n")
      end

      desc 'returns more info on given command'
      on /^help (.+)/ do |subject|
        reactions = Hipbot.reactions.select do |reaction|
          [reaction.plugin_name, reaction.readable_command, reaction.desc].any?{ |v| v =~ /#{subject}/i }
        end
        help = []
        reactions.each do |reaction|
          help << "#{reaction.plugin_name}: #{reaction.readable_command}"
          if !reaction.desc.nil?
            help << "  - #{reaction.desc}"
          end

          if reaction.to_private_message?
            help << "  - Private only"
          elsif reaction.in_any_room?
            help << "  - Room only"
          elsif reaction.rooms.any?
            help << "  - Only in: #{reaction.rooms.to_sentence}"
          else
            help << "  - All rooms and private messages"
          end

          if !reaction.options[:from].nil?
            help << "  - Only for: #{reaction.users.to_sentence}"
          else
            help << "  - From anybody"
          end

          if reaction.global?
            help << "  - Without mention"
          end
        end
        reply help.join("\n")
      end
    end
  end
end
