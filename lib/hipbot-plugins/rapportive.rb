require 'open-uri'
require 'active_support/core_ext'

module Hipbot
  module Plugins
    class Rapportive
      include Hipbot::Plugin

      desc 'do something'
      on /^raport (\S*) (\S*) from (.*)/ do |firstname, lastname, domain|
        raport = Rapportive.new(firstname, lastname, domain)
        reply(raport.to_s)
      end

      class Rapportive
        attr_accessor :firstname, :lastname, :domain
        
        class << self
            attr_accessor :token
        end
        
        def initialize(firstname, lastname, domain)
          self.firstname = firstname
          self.lastname = lastname
          self.domain = domain
        end

        def to_s
          log_in
          puts self.class.token.inspect
          return "Sorry, I could not find email address" if profile.nil?
          "Found it! Email #{profile['contact']['email']} is valid."
        end

        private

        def log_in
          if self.class.token.nil?
            session = open(session_token_url).read
            self.class.token = JSON.parse(session).fetch('session_token') { "" }
          end
        end

        def session_token_url
          "https://rapportive.com/login_status?user_email=#{random_email}"
        end

        def profile
          emails.each do |email|
            begin
              body = open(profiles_url(email), "X-Session-Token" => self.class.token).read
              contact = JSON.parse(body)
              return contact if found?(contact)
            rescue OpenURI::HTTPError => e
              self.class.token = nil
            end
          end
          nil
        end

        def profiles_url(email)
          "https://profiles.rapportive.com/contacts/email/#{email}"
        end

        def emails
          [
            "#{firstname}.#{lastname}",
            "#{firstname}#{lastname}",
            "#{firstname_letter}#{lastname}",
            "#{firstname_letter}.#{lastname}",
            "#{firstname}",
            "#{lastname}",
            "#{firstname}-#{lastname}",
            "#{firstname}_#{lastname}"
          ].map do |email|
            email + '@' + domain
          end
        end

        def firstname_letter
          self.firstname[0]
        end

        def random_email
          SecureRandom.hex + '@gmail.com'
        end

        def found?(contact)
          puts contact['contact']['first_name'].inspect
          puts contact['contact']['last_name'].inspect
          contact['contact']['first_name'] != "" && contact['contact']['last_name'] != ""
        end
      end
    end
  end
end
