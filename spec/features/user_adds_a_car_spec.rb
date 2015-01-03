require "rails_helper"

feature "Add a type manufacturer", %q{
  As a car salesperson
  I want to record a newly acquired car
  So that I can list it in my lot

  Acceptance Criteria:

  * I must specify the manufacturer, color, year,
  and mileage of the car (an association between
  the car and an existing manufacturer should be created).
  * Only years from 1920 and above can be specified.
  * I can optionally specify a description of the car.
  * If I enter all of the required information in the
  required formats, the car is recorded and I am
  presented with a notification of success.
  * If I do not specify all of the required information
  in the required formats, the car is not recorded and
  I am presented with errors.
  * Upon successfully creating a car, I am redirected
  back to the index of cars.
  } do
    scenario "salesperson fills in all feilds, creates a car and goes to index" do
      manufacturer = Manufacturer.create(name: "kia", country: "korea")
      car = Car.new(color: "orange", year: 2013, mileage:18_000, manufacturer_id: manufacturer.id)
      visit new_car_path
      fill_in "Color", with: car.color
      fill_in "Year", with: car.year
      fill_in "Mileage", with: car.mileage
      fill_in "Description", with: car.description
      select(car.manufacturer.name, :from => "car[manufacturer_id]")
      click_button("Create Car")
      expect(page).to have_content "Cars" # heading
      expect(page).to_not have_content "error" || "errors" # no error message
      expect(page).to have_content "successfully" # sucess message flash notice
      expect(page).to have_content car.manufacturer.name
      expect(page).to have_content car.color
    end

    scenario "salesperson fills in a car from before 1920" do
      manufacturer = Manufacturer.create(name: "kia", country: "korea")
      car = Car.new(color: "orange", year: 1910, mileage:18_000, manufacturer_id: manufacturer.id)
      visit new_car_path
      fill_in "Color", with: car.color
      fill_in "Year", with: car.year
      fill_in "Mileage", with: car.mileage
      select(car.manufacturer.name, :from => "car[manufacturer_id]")
      click_button("Create Car")
      expect(page).to have_content "error" || "errors" # no error message
    end

    scenario "salesperson does not fill in all values" do
      visit new_car_path
      click_button("Create Car")
      #expect content that is on the index page
      expect(page).to have_content "error" || "errors" # Error
    end

    scenario "salesperson enters no desciption and its a sucess" do
      manufacturer = Manufacturer.create(name: "kia", country: "korea")
      car = Car.new(color: "orange", year: 2013, mileage:18_000, manufacturer_id: manufacturer.id)
      visit new_car_path
      fill_in "Color", with: car.color
      fill_in "Year", with: car.year
      fill_in "Mileage", with: car.mileage
      select(car.manufacturer.name, :from => "car[manufacturer_id]")
      click_button("Create Car")
      expect(page).to have_content "Cars" # heading
      expect(page).to_not have_content "error" || "errors" # no error message
      expect(page).to have_content "successfully" # sucess message flash notice
      expect(page).to have_content car.manufacturer.name
      expect(page).to have_content car.color
    end
  end
