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

      ahref = f.css('tr').css('a')[$link_iterator].to_s # get
      index_of_special = /v=/ =~ ahref #special
      special_type = ahref[index_of_special + 2, 1] #value

      route_info["routenumber"] = f.css('tr').css('a')[$link_iterator].text()
      route_info["route_from_to"] = f.css('tr').css('td[title="Route details"]')[$route_iterator].text()
      route_info["cost"] = f.css('tr').css('td[title="($)Adult Fare"]')[$route_iterator].text()
      route_info["special"] = special_type
      $link_iterator +=1
      $route_iterator +=1
      Route.create(route_info)
      puts route_info
    end
  end
end
