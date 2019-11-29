require "application_system_test_case"

class IncidenceTypesTest < ApplicationSystemTestCase
  setup do
    @incidence_type = incidence_types(:one)
  end

  test "visiting the index" do
    visit incidence_types_url
    assert_selector "h1", text: "Incidence Types"
  end

  test "creating a Incidence type" do
    visit incidence_types_url
    click_on "New Incidence Type"

    click_on "Create Incidence type"

    assert_text "Incidence type was successfully created"
    click_on "Back"
  end

  test "updating a Incidence type" do
    visit incidence_types_url
    click_on "Edit", match: :first

    click_on "Update Incidence type"

    assert_text "Incidence type was successfully updated"
    click_on "Back"
  end

  test "destroying a Incidence type" do
    visit incidence_types_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Incidence type was successfully destroyed"
  end
end
