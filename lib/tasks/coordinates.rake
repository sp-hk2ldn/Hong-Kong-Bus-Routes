# namespace :businfo do
#   desc "Scrape stop coordinates"

#   task :coordinates => :environment do
#     require 'open-uri'
#     require 'nokogiri'
#     require 'watir-webdriver'

#     url = "http://mobileapp.nwstbus.com.hk/nw/?l=1&f=0"
#     document = open(url).read
#     html_doc = Nokogiri::HTML(document)

#     b = Watir::Browser.new :chrome
#     b.goto url
#     sleep 5
#     b.execute_script("gomenu(1)")
#     sleep 5
#     b.execute_script("search_cookie('X',document.ksearch.skey.value,0);")
#     sleep 5
#     b.execute_script("showroute('1   ','T','D',true)")
#     sleep 5
#     html_doc = Nokogiri::HTML.parse(b.html)


#     lnglat = html_doc.css('#slist1').attr('onclick').value
#     latitude = lnglat[15,17]
#     longitude = lnglat[33,17]

#     puts latitude
#     puts longitude
#   end
# end

namespace :businfo do
  desc "Scrape stop coordinates"

  task :coordinates => :environment do
    require 'open-uri'
    require 'nokogiri'
    require 'watir-webdriver'

    url = "http://mobileapp.nwstbus.com.hk/nw/?l=1&f=0"
    document = open(url).read
    html_doc = Nokogiri::HTML(document)
    @routes = Route.all
    @routes.each do |route|
      @route_details = Detail.where("route_id = " + route.id.to_s + " AND travel_direction = \'ForwardRoute\'").sort
      @route_details.each do |route_detail|
        if route_detail.travel_direction = "ForwardRoute" then
          direction = "\'T\'"
        else
          direction = "\'R\'"
        end

        b = Watir::Browser.new :chrome
        b.goto url
        sleep 5
        b.execute_script("gomenu(1)")
        sleep 5
        b.execute_script("search_cookie('X',document.ksearch.skey.value,0);")
        sleep 5
        b.execute_script("showroute('1   '," + direction.to_s + ",'D',true)")
        sleep 5
        html_doc = Nokogiri::HTML.parse(b.html)
        css_incrementor = route_detail.stop_number.to_s
        lnglat = html_doc.css('#slist' + css_incrementor).attr('onclick').value
        latitude = lnglat[15,17]
        longitude = lnglat[33,17]
        route_detail.update(latitude: latitude)
        route_detail.update(longitude: longitude)
      end
    end
  end
end