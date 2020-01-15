require "application_system_test_case"

class InterestPointsTest < ApplicationSystemTestCase
  setup do
    @interest_point = interest_points(:one)
  end

  test "visiting the index" do
    visit interest_points_url
    assert_selector "h1", text: "Interest Points"
  end

  test "creating a Interest point" do
    visit interest_points_url
    click_on "New Interest Point"

    click_on "Create Interest point"

    assert_text "Interest point was successfully created"
    click_on "Back"
  end

  test "updating a Interest point" do
    visit interest_points_url
    click_on "Edit", match: :first

    click_on "Update Interest point"

    assert_text "Interest point was successfully updated"
    click_on "Back"
  end

  test "destroying a Interest point" do
    visit interest_points_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Interest point was successfully destroyed"
  end
end
