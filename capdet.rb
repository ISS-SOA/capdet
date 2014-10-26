require 'httparty'
require 'json'
require 'yaml'

##
# Contains classes to call codecadet web service
module Capdet
  # API_URL = 'http://localhost:9292/api'
  API_URL = 'http://simplecadet.herokuapp.com/api'
  VER = 'v1'
  EXT = 'json'
  RESOURCE = 'cadet'
  ##
  # Captures information about a single user
  class Cadet
    attr_reader :name, :type, :badges

    def initialize
    end

    def initialize(username)
      get_user(username)
    end

    def get_user(username)
      request_url = "#{API_URL}/#{VER}/#{RESOURCE}/#{username}.#{EXT}"
      cadet_h = HTTParty.get(request_url)

      @name = cadet_h['id']
      @type = cadet_h['type']
      @badges = {}
      cadet_h['badges'].each do |badge|
        @badges[badge['id']] = badge['date']
      end
    end
  end

  ##
  # Captures user group level information
  class Academy
    def self.check(usernames, badges)
      params_h = {
        usernames: usernames,
        badges: badges
      }
      url = "#{Capdet::API_URL}/#{Capdet::VER}/check"
      options = { body: params_h.to_json,
                  headers: { 'Content-Type' => 'application/json' }
                }
      response = HTTParty.post(url, options)
      puts response
    end
  end
end

# cap = Capdet::Cadet.new('soumya.ray')
# puts cap.badges.to_yaml

# Capdet::Academy.check(['soumya.ray', 'chenlizhan'],
#                      ['Object-Oriented Programming II'])
