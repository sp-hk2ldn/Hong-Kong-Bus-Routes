namespace :businfo do
  desc "Scrape Routes"

  task :routes => :environment do
    require 'open-uri'
    require 'nokogiri'
    url = 'http://mobileapp.nwstbus.com.hk/text/routesearch.php?textOnly=true&searchtype=&l=0&l=1'
    document = open(url).read


    html_doc = Nokogiri::HTML(document)
    get_route_information(html_doc)
  end


  def get_route_information(f)
    $link_iterator = 9
    $route_iterator = 0 
    route_info = Hash.new
    f.css('tr').css('a').each do

      #extract special, direction, company information from link

      a_href = f.css('tr').css('a')[$link_iterator].to_s
      index_of_special = /v=/ =~ a_href
      special_type = a_href[index_of_special + 2, 1]
      index_of_direction = /d=/ =~ a_href
      direction_type = a_href[index_of_direction +2, 1]
      index_of_company = /company=/ =~ a_href
      company_type = a_href[index_of_company +8, 1]


      #build hash to insert into database
      
      route_info["routenumber"] = f.css('tr').css('a')[$link_iterator].text()
      route_info["route_from_to"] = f.css('tr').css('td[title="Route details"]')[$route_iterator].text()
      route_info["cost"] = f.css('tr').css('td[title="($)Adult Fare"]')[$route_iterator].text()
      route_info["special"] = special_type
      route_info["direction"] = direction_type
      route_info["company"] = company_type
      $link_iterator +=1
      $route_iterator +=1
      Route.create(route_info)
      puts route_info
    end
  end
end
