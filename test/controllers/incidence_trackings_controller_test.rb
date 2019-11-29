require 'test_helper'

class IncidenceTrackingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @incidence_tracking = incidence_trackings(:one)
  end

  test "should get index" do
    get incidence_trackings_url
    assert_response :success
  end

  test "should get new" do
    get new_incidence_tracking_url
    assert_response :success
  end

  test "should create incidence_tracking" do
    assert_difference('IncidenceTracking.count') do
      post incidence_trackings_url, params: { incidence_tracking: {  } }
    end

    assert_redirected_to incidence_tracking_url(IncidenceTracking.last)
  end

  test "should show incidence_tracking" do
    get incidence_tracking_url(@incidence_tracking)
    assert_response :success
  end

  test "should get edit" do
    get edit_incidence_tracking_url(@incidence_tracking)
    assert_response :success
  end

  test "should update incidence_tracking" do
    patch incidence_tracking_url(@incidence_tracking), params: { incidence_tracking: {  } }
    assert_redirected_to incidence_tracking_url(@incidence_tracking)
  end

  test "should destroy incidence_tracking" do
    assert_difference('IncidenceTracking.count', -1) do
      delete incidence_tracking_url(@incidence_tracking)
    end

    assert_redirected_to incidence_trackings_url
  end
end
