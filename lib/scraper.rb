class Scraper

  def self.get_companies
    url = open("https://www.visitbutlercounty.com/BeerCircuit")
    doc = Nokogiri::HTML.parse(url)

    doc.css("div.pane-content").css("div.col-md-3").each do |brewery|
      name = brewery.css("h4").css("a").text.strip
      desc = brewery.css("p").text.gsub(/[\u200B]/, '') #Regex for removing the "<U+200B>" string that existed in the Recon Brewery description
      url = brewery.css("h4").css("a").attr("href").to_s
      Brewery.new(name, desc, url) if (!name.empty?)
    end
  end

  # def self.company_data(brewery)
  #
  # end

end



