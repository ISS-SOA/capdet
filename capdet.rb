require 'open-uri'
require 'json'
require 'yaml'

class Cadet
  attr_reader :name, :type, :badges
  def initialize(username)
    cadet_json = open("https://codebadges.herokuapp.com/api/v1/cadet/#{username}.json").read
    cadet_h = JSON.parse(cadet_json)

    @name = cadet_h['id']
    @type = cadet_h['type']
    @badges = {}
    cadet_h['badges'].each do |badge|
      @badges[badge['id']] = badge['date']
    end
  end
end

cap = Cadet.new('soumya.ray')
puts cap.badges.to_yaml
