namespace :businfo do
  desc "Scrape Route details"

  task :details => :environment do
    require 'open-uri'
    require 'nokogiri'

    @routes = Route.all
    route_number = [1,2,3]
    # @routes.each do |route|
    #   route_number.push(route.routenumber)
    # end
    # puts route_number
    #T is "forwards" and circular, R is reverse
    direction = ["T","R"]

    #S = special, M = morning peak only, H = horse racing/leisure days only, P = morning/evening peak only, D = normal, N = nightbus E = evening peak only
    special = ["S", "M", "H", "P", "D", "N", "E"]

    company = [5,7]



    route_number.each do |route_number|
      direction.each do |direction|
        special.each do |special|
          company.each do |company|
            url = "http://mobileapp.nwstbus.com.hk/text/getstopinroute.php?r=#{route_number}&d=#{direction}&v=#{special}&company=#{company}&from=routesearch"            
            document = open(url).read
            html_doc = Nokogiri::HTML(document)
            # td_with_title = html_doc.xpath('/table[3]/tbody/tr[2]/td')
            td_with_title = html_doc.xpath('//table')
            puts td_with_title.text()
            # puts stops.text

            # puts html_doc.css(stops).text 
            
          end
        end
      end
    end

  end
end