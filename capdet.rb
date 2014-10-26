require 'open-uri'
require 'json'
require 'yaml'

##
# This class captures information about a user returned codebadges.herokuapp.com
class Cadet
  attr_reader :name, :type, :badges

  URL = 'https://codebadges.herokuapp.com/api/'
  VER = 'v1'
  EXT = 'json'
  RESOURCE = 'cadet'

  def initialize(username)
    cadet_json = open("#{URL}/#{VER}/#{RESOURCE}/#{username}.#{EXT}").read
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
