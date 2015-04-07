json.array!(@routes) do |route|
  json.extract! route, :id, :routenumber, :route_from_to, :cost
  json.url route_url(route, format: :json)
end
