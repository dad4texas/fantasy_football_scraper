require_relative '../environment'

require 'nokogiri'
require 'open-uri'
require 'pry'


class FantasyFootballScraper::Scraper

  def self.scrape_players(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    players_array = []
    index_page.css("tr").first(30).each do |qb|
    player_name = qb.css(".player-name").text 
    team = qb.css(".player-label+ .center").text
    player_rank = qb.css(".center:nth-child(1)").text 
    fantasy_points = qb.css(".center:nth-child(5)").text
    pro_link = qb.css('td.player-label a').first(30).map { |link| link['href']}
    profile_link = "https://www.fantasypros.com" + pro_link.join('') 
    players_array << {name: player_name, rank:player_rank, team: team, 
    fantasy_points: fantasy_points, profile_link: profile_link
    } 
   
  end 
    players_array
 end

end