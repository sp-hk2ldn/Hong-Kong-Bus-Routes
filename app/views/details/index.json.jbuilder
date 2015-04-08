json.array!(@details) do |detail|
  json.extract! detail, :id, :stop_number, :stop_name, :stop_location, :area, :adult_price, :child_price, :senior_price
  json.url detail_url(detail, format: :json)
end
