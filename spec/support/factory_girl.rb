require 'factory_girl'

FactoryGirl.define do

  factory :car do
    color "White"
    year 2012
    mileage 20_000
    description "well maintained beauty!"

    manufacturer
  end

  factory :manufacturer do
    # sequence(:name) { |n| "Kia#{n}" }
    name "kia"
    country "Korea"

    car
  end

end
