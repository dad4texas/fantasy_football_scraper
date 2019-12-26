require 'pry'
require 'nokogiri'
require 'open-uri'
require 'colorize'

require_relative './fantasy_football_scraper/version'
require_relative './fantasy_football_scraper/cli'
require_relative './fantasy_football_scraper/scraper'
require_relative './fantasy_football_scraper/players'

module FantasyFootballScraper
  class Error < StandardError; end
  # Your code goes here...
end
