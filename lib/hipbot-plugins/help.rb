module Hipbot
  module Plugins
    class Help
      include Hipbot::Plugin

      desc 'generates help for all reactions'
      on /^help$/ do
        reactions_with_description = Hipbot.plugin_reactions.reject{ |reaction| reaction.desc.nil? }
        help = reactions_with_description.map do |reaction|
          "#{reaction.plugin_name}: #{reaction.readable_command} - #{reaction.desc}"
        end
        reply help.join("\n")
      end

      desc 'returns more info on given command'
      on /^help (.+)/ do |subject|
        reactions = Hipbot.plugin_reactions.select{ |reaction| reaction.plugin_name == subject || reaction.readable_command =~ /#{subject}/ || reaction.desc =~ /#{subject}/ }
        help = []
        reactions.each do |reaction|
          help << "#{reaction.plugin_name}: #{reaction.readable_command}"
          if reaction.desc.present?
            help << "  - #{reaction.desc}"
          end

          if reaction.private_message_only?
            help << "  - Private only"
          elsif reaction.any_room?
            help << "  - Room only"
          elsif reaction.rooms.any?
            help << "  - Only in: #{reaction.rooms.to_sentence}"
          else
            help << "  - All rooms and private messages"
          end

          if reaction.options[:from].present?
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
