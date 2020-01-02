require_relative '../environment'

class FantasyFootballScraper::CLI

  def run
    fantasy_fb_kickoff
    make_players
    display_players
    get_attributes 
    
  end


  def fantasy_fb_kickoff
            
   puts "Welcome to the Fantasy Football players Selector. If you would like see the fantasy ranking of the top NFL players
    enter".green + " yes".red + " if not enter".green + " no".red 

      choice = gets.chomp
      
        case choice.downcase

          when 'yes'  #need loop to handle bad data'
            make_players
            
          when'no'
            puts "HAVE A WONDERFUL DAY!".blue
            end_program

          else
            puts "I DON'T UNDERSTAND YOUR ANSWER. Please try again!".red
            fantasy_fb_kickoff
      end    
  end

  def end_program
    puts "Have a Wonderful Day!".blue
    abort
  end

    BASE_PATH = "https://www.fantasypros.com/nfl/reports/leaders/"

  def make_players
    player_array = FantasyFootballScraper::Scraper.scrape_players(BASE_PATH)
    FantasyFootballScraper::Players.create_from_collection(player_array)
  end 

  def get_attributes #gets the link associtated with the player attributes page
    attributes_array = make_players
    player_link = attributes_array.map {|x| x.values[4]} #array of hashes, 4 is where link value in hashes
    
    puts "Enter the rank number of a player to get detailed information or type 'x' to exit the program."
    input = gets.chomp 

      if input == "x"
        end_program 

      else 
       number_get = input.strip.to_i
      end
    #number_get = gets.strip.to_i #gets user input 
    url = player_link[number_get]
  
    doc = Nokogiri::HTML(open(url))
    puts "#{doc.css("h1").text}".red
    puts "height:  ".blue + "#{doc.css(".bio-detail:nth-child(1)").text}"
    puts "weight:  ".blue + "#{doc.css(".bio-detail:nth-child(2)").text}"
    puts "age:  ".blue + "#{doc.css(".bio-detail:nth-child(3)").text}"
    puts "college:  ".blue +  "#{doc.css(".bio-detail:nth-child(4)").text}"
    puts "next game: ".blue + "#{doc.css("div.next-game").text}"
    puts "latest news:  ".green + "#{doc.css("p").text}"
    get_attributes
  end 

  def display_players
 players = FantasyFootballScraper::Players.all
    players_minus_first_index =  players[1..30]
    players_minus_first_index.each do |player|
      puts "  Rank:".red + " #{player.rank}"
      puts "  Name:".blue + " #{player.name}"
      puts "  Team:".blue + " #{player.team}"
      puts "  Fantasy Points:  ".blue + "#{player.fantasy_points}"
      puts "  Profile Link".green + " #{player.profile_link}"
      puts "______________________________________________________________________________".green
  end
 end
end



    
