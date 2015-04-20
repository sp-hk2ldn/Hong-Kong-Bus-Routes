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

    @routes = Route.all.sort
    @routes.each do |route|
      b = Watir::Browser.new :chrome
      check_if_coordinates_present = Detail.where(route_id: route.id)
      puts check_if_coordinates_present.id
      if check_if_coordinates_present.last.latitude == null then
        puts check_if_coordinates_present
        url = "http://mobileapp.nwstbus.com.hk/nw/?l=1&f=0"
        document = open(url).read
        html_doc = Nokogiri::HTML(document)
        b.goto url
        sleep 2
        b.execute_script("gomenu(1)")
        sleep 2
        b.execute_script("search_cookie('X',document.ksearch.skey.value,0);")
        sleep 2
        @route_details = Detail.where("route_id = " + route.id.to_s).sort
        # @route_details = Detail.where("route_id = " + route.id.to_s + " AND travel_direction = \'ForwardRoute\'").sort
        @route_details.each do |route_detail|
          direction = "\'" + route.direction + "\'"
          special = "\'" + route.special + "\'"

          # b.execute_script("showroute('1   '," + direction.to_s + ",'D',true)")
          b.execute_script("showroute(' " + route.routenumber + "'," + direction + "," + special + ",true)")
          sleep 0.5
          html_doc = Nokogiri::HTML.parse(b.html)
          css_incrementor = route_detail.stop_number.to_s
          lnglat = html_doc.css('#slist' + css_incrementor).attr('onclick').value
          latitude = lnglat[15,17]
          longitude = lnglat[33,17]
          route_detail.update(latitude: latitude)
          route_detail.update(longitude: longitude)
      end

      end
      b.close
    end
  end
end