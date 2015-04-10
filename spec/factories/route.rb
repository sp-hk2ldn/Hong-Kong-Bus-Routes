FactoryGirl.define do
  factory :route do
    route_from_to { Faker::Address.street_address }
    cost {"10"}
    special {"D"}
    direction {"T"}
    company {5}

  end
end
