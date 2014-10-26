#!/usr/bin/env ruby

require 'open-uri'
require 'httparty'
require 'json'
require 'yaml'

module Capdet
  API_URL = 'http://localhost:9292/api'
  VER = 'v1'
  EXT = 'json'
  RESOURCE = 'cadet'
  ##
  # This class captures information about a user returned codebadges.herokuapp.com
  class Cadet
    attr_reader :name, :type, :badges

    def initialize
    end

    def initialize(username)
      get(username)
    end

    def get(username)
      cadet_json = open("#{API_URL}/#{VER}/#{RESOURCE}/#{username}.#{EXT}").read
      cadet_h = JSON.parse(cadet_json)

      @name = cadet_h['id']
      @type = cadet_h['type']
      @badges = {}
      cadet_h['badges'].each do |badge|
        @badges[badge['id']] = badge['date']
      end
    end
  end

  ##
  # Runs class level operations from codebadges.herokuapp.com
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

# cap = Cadet.new('soumya.ray')
# puts cap.badges.to_yaml

#Capdet::Academy.check(['soumya.ray', 'chenlizhan'],
#                      ['Object-Oriented Programming II'])
