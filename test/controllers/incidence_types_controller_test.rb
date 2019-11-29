require 'test_helper'

class IncidenceTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @incidence_type = incidence_types(:one)
  end

  test "should get index" do
    get incidence_types_url
    assert_response :success
  end

  test "should get new" do
    get new_incidence_type_url
    assert_response :success
  end

  test "should create incidence_type" do
    assert_difference('IncidenceType.count') do
      post incidence_types_url, params: { incidence_type: {  } }
    end

    assert_redirected_to incidence_type_url(IncidenceType.last)
  end

  test "should show incidence_type" do
    get incidence_type_url(@incidence_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_incidence_type_url(@incidence_type)
    assert_response :success
  end

  test "should update incidence_type" do
    patch incidence_type_url(@incidence_type), params: { incidence_type: {  } }
    assert_redirected_to incidence_type_url(@incidence_type)
  end

  test "should destroy incidence_type" do
    assert_difference('IncidenceType.count', -1) do
      delete incidence_type_url(@incidence_type)
    end

    assert_redirected_to incidence_types_url
  end
end
