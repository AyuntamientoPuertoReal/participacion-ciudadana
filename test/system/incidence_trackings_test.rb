require "application_system_test_case"

class IncidenceTrackingsTest < ApplicationSystemTestCase
  setup do
    @incidence_tracking = incidence_trackings(:one)
  end

  test "visiting the index" do
    visit incidence_trackings_url
    assert_selector "h1", text: "Incidence Trackings"
  end

  test "creating a Incidence tracking" do
    visit incidence_trackings_url
    click_on "New Incidence Tracking"

    click_on "Create Incidence tracking"

    assert_text "Incidence tracking was successfully created"
    click_on "Back"
  end

  test "updating a Incidence tracking" do
    visit incidence_trackings_url
    click_on "Edit", match: :first

    click_on "Update Incidence tracking"

    assert_text "Incidence tracking was successfully updated"
    click_on "Back"
  end

  test "destroying a Incidence tracking" do
    visit incidence_trackings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Incidence tracking was successfully destroyed"
  end
end
