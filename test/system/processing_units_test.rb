require "application_system_test_case"

class ProcessingUnitsTest < ApplicationSystemTestCase
  setup do
    @processing_unit = processing_units(:one)
  end

  test "visiting the index" do
    visit processing_units_url
    assert_selector "h1", text: "Processing Units"
  end

  test "creating a Processing unit" do
    visit processing_units_url
    click_on "New Processing Unit"

    click_on "Create Processing unit"

    assert_text "Processing unit was successfully created"
    click_on "Back"
  end

  test "updating a Processing unit" do
    visit processing_units_url
    click_on "Edit", match: :first

    click_on "Update Processing unit"

    assert_text "Processing unit was successfully updated"
    click_on "Back"
  end

  test "destroying a Processing unit" do
    visit processing_units_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Processing unit was successfully destroyed"
  end
end
