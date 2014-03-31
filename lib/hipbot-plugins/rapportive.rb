require 'open-uri'

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

        def initialize(firstname, lastname, domain)
          self.firstname = firstname
          self.lastname = lastname
          self.domain = domain
        end

        def to_s
          return "Sorry, I could not find email address" if profile.nil?
          "Found it! Email #{profile['contact']['email']} is valid."
        end

        private

        def session_token
          begin
            @token ||= open(session_token_url).read
            JSON.parse(@token).fetch(:session_token) { "" }
          rescue OpenURI::HTTPError
            ""
          end
        end

        def session_token_url
          "https://rapportive.com/login_status?user_email=#{random_email}"
        end

        def profile
          emails.each do |email|
            begin
              body = open(profiles_url(email), "X-Session-Token" => session_token).read
              contact = JSON.parse(body)
              return contact if found?(contact)
            rescue OpenURI::HTTPError
              nil # returns nil for check in to_s method - requests limit reached
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
          contact['contact']['first_name'] != "" && contact['contact']['last_name'] != ""
        end
      end
    end
  end
end
