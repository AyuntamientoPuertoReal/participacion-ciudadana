require 'test_helper'

class InterestPointsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @interest_point = interest_points(:one)
  end

  test "should get index" do
    get interest_points_url
    assert_response :success
  end

  test "should get new" do
    get new_interest_point_url
    assert_response :success
  end

  test "should create interest_point" do
    assert_difference('InterestPoint.count') do
      post interest_points_url, params: { interest_point: {  } }
    end

    assert_redirected_to interest_point_url(InterestPoint.last)
  end

  test "should show interest_point" do
    get interest_point_url(@interest_point)
    assert_response :success
  end

  test "should get edit" do
    get edit_interest_point_url(@interest_point)
    assert_response :success
  end

  test "should update interest_point" do
    patch interest_point_url(@interest_point), params: { interest_point: {  } }
    assert_redirected_to interest_point_url(@interest_point)
  end

  test "should destroy interest_point" do
    assert_difference('InterestPoint.count', -1) do
      delete interest_point_url(@interest_point)
    end

    assert_redirected_to interest_points_url
  end
end
