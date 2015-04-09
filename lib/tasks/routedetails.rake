namespace :businfo do
  desc "Scrape Route details"

  task :details => :environment do
    require 'open-uri'
    require 'nokogiri'

    @routes = Route.all
    route_number = Array.new
    route_ids = Array.new
    # special = Array.new
    @routes.each do |route|
      route_ids.push(route.id)
      route_number.push(route.routenumber.gsub(/\s+/, ""))
      # special.push(route.special)
    end

    # route_number << "1"
    #T is "forwards" and circular, R is reverse
    direction = ["T","R"]

    #S = special, M = morning peak only, H = horse racing/leisure days only, P = morning/evening peak only, D = normal, N = nightbus E = evening peak only
    special = ["S", "M", "H", "P", "D", "N", "E"]

    company = ["5","7"]


    @routes.each do |route|
      direction.each do |direction|
        special.each do |special|
          company.each do |company|
            url = "http://mobileapp.nwstbus.com.hk/text/getstopinroute.php?r=" + route.routenumber.gsub(/\s+/, "") + "&d=#{direction}&v=#{special}&company=#{company}&from=routesearch&l=1"            
            document = open(url).read
            html_doc = Nokogiri::HTML(document)
            table = html_doc.css('table')[2]
            tr = table.css('tr')

            stop_information = Hash.new
            for i in 0..tr.length - 1 do
              stop_number = tr[i].css('td:nth-child(1)').text
              stop_name = tr[i].css('td:nth-child(2)').text
              stop_location = tr[i].css('td:nth-child(3)').text
              district = tr[i].css('td:nth-child(4)').text
              adult = tr[i].css('td:nth-child(5)').text
              child = tr[i].css('td:nth-child(6)').text
              senior = tr[i].css('td:nth-child(7)').text
              travel_direction = ""

              if direction == "T" then
                travel_direction = "ForwardRoute"
              else
                travel_direction = "BackwardRoute"
              end
              if stop_number.length != 0 then
                stop_information["child_price"] = child
                stop_information["adult_price"] = adult
                stop_information["senior_price"] = senior
                stop_information["route_id"] = route.id
                stop_information["stop_number"] = stop_number
                stop_information["stop_name"] = stop_name
                stop_information["stop_location"] = stop_location
                stop_information["area"] = district
                stop_information["travel_direction"] = travel_direction
                Detail.create(stop_information)
                puts stop_information
                sleep(2)
              end
            end            
          end
        end
      end
    end

  end
end