class Cli

  def call
    Scraper.get_companies
    input = ""
    while(input != 'exit') do
      puts ''
      puts "Welcome to the Butler County Beer Circuit"
      puts "Here is a list of our local County Breweries: "
      puts "(Select a number to find out more information!)"
      puts "(Enter 'exit' to exit program.)"
      list_breweries
      input = gets.chomp

      if input != 'exit' && (input.to_i < 1 || input.to_i > Brewery.all.length)
        begin
          raise InvalidSelectionError
        rescue InvalidSelectionError => error
          puts error.message
        end
      else
        brewery_info(input.to_i)
      end
    end
  end

  def list_breweries
    Brewery.all.each.with_index(1) do |brewery, idx|
      puts "#{idx}. #{brewery.name}"
    end
  end

  def brewery_info(brewery)
    puts "*~~~~~~~~~~~~~~~~~*"
    puts "-#{Brewery.all[brewery - 1].name}-"
    puts "*~~~~~~~~~~~~~~~~~*"
    puts "#{Brewery.all[brewery - 1].description}"
    puts ''
    if (Brewery.all[brewery - 1].url == '#')
      puts "Website coming soon..."
    else
      puts "Visit us at: #{Brewery.all[brewery - 1].url}"
    end
  end

  class InvalidSelectionError < StandardError
    def message
      "Invalid selection.  Please try again..."
    end
  end
end