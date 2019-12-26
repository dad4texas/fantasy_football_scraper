require_relative '../environment'

class FantasyFootballScraper::Players
  attr_accessor :name, :rank, :team, :fantasy_points, :profile_link

  @@all = []

  def initialize(player_hash)
    player_hash.each do |attribute, value|
    self.send("#{attribute}=", value)
    end
    @@all << self
  end

  def self.create_from_collection(player_array) 
    player_array.each do |player_hash|
        FantasyFootballScraper::Players.new(player_hash)
    end
  end

  def self.all
    @@all
    
  end
end