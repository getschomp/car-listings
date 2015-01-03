require "rails_helper"

feature "Add a type manufacturer", %q{
  As a type salesperson
  I want to record a type manufacturer
  So that I can keep track of the types of types found in the lot.

  Acceptance Criteria:

  * I must specify a manufacturer name and country.
  * If I do not specify the required information,
    I am presented with errors.
  * If I specify the required information,
    the manufacturer is recorded and I am redirected
    to the index of manufacturers
    } do

      scenario "salesperson fills in all feilds and creates a manufacturer" do
        # manufacturer = FactoryGirl.build(:manufacturer)
        manufacturer = Manufacturer.new(name: "kia", country: "korea")
        visit new_manufacturer_path
        fill_in "Name", with: manufacturer.name
        fill_in "Country", with: manufacturer.country
        click_button("Create Manufacturer")
        expect(page).to have_content "Manufacturers" # heading
        expect(page).to_not have_content "Error" # no error message
        expect(page).to have_content "successfully" # sucess message flash notice
        expect(page).to have_content manufacturer.name
        expect(page).to have_content manufacturer.country
      end

      scenario "salesperson does not fill in required feilds" do
        visit new_manufacturer_path
        click_button("Create Manufacturer")
        #expect content that is on the index page
        expect(page).to have_content "error" || "errors" # Error
      end

      scenario "salesperson enters a type that is already in the database" do
        Manufacturer.create(name: "Kia1", country: "Korea1")
        visit new_manufacturer_path
        fill_in "Name", with: "Kia1"
        fill_in "Country", with: "Korea1"
        click_button("Create Manufacturer")
        expect(page).to have_content "error" || "errors"
      end
    end
