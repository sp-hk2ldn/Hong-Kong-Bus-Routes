namespace :businfo do
  desc "Scrape Route details"

  task :details => :environment do
    require 'open-uri'
    require 'nokogiri'

    @routes = Route.all
    route_number = Array.new
    @routes.each do |route|
      route_number.push(route.routenumber.gsub(/\s+/, ""))
    end
    # puts route_number
    #T is "forwards" and circular, R is reverse
    direction = ["T","R"]

    #S = special, M = morning peak only, H = horse racing/leisure days only, P = morning/evening peak only, D = normal, N = nightbus E = evening peak only
    special = ["S", "M", "H", "P", "D", "N", "E"]

    company = ["5","7"]



    route_number.each do |route_number|
      direction.each do |direction|
        special.each do |special|
          company.each do |company|
            url = "http://mobileapp.nwstbus.com.hk/text/getstopinroute.php?r=#{route_number}&d=#{direction}&v=#{special}&company=#{company}&from=routesearch&l=1"            
            document = open(url).read
            html_doc = Nokogiri::HTML(document)
            table = html_doc.css('table')[2]
            tr = table.css('tr')

            stop_information = Hash.new
            for i in 0..tr.length - 1 do
              stop = tr[i].css('td:nth-child(1)').text
              bus_stop = tr[i].css('td:nth-child(2)').text
              bus_stop_location = tr[i].css('td:nth-child(3)').text
              area = tr[i].css('td:nth-child(4)').text
              adult = tr[i].css('td:nth-child(5)').text
              child = tr[i].css('td:nth-child(6)').text
              senior = tr[i].css('td:nth-child(7)').text
              if stop.length != 0 then
                stop_information["route_id"] = route_number
                stop_information["stop_number"] = stop
                stop_information["stop name"] = bus_stop
                stop_information["stop_location"] = bus_stop_location
                stop_information["district"] = area
                puts stop_information
              end
            end            
          end
        end
      end
    end

  end
end