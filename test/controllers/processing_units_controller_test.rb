require 'test_helper'

class ProcessingUnitsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @processing_unit = processing_units(:one)
  end

  test "should get index" do
    get processing_units_url
    assert_response :success
  end

  test "should get new" do
    get new_processing_unit_url
    assert_response :success
  end

  test "should create processing_unit" do
    assert_difference('ProcessingUnit.count') do
      post processing_units_url, params: { processing_unit: {  } }
    end

    assert_redirected_to processing_unit_url(ProcessingUnit.last)
  end

  test "should show processing_unit" do
    get processing_unit_url(@processing_unit)
    assert_response :success
  end

  test "should get edit" do
    get edit_processing_unit_url(@processing_unit)
    assert_response :success
  end

  test "should update processing_unit" do
    patch processing_unit_url(@processing_unit), params: { processing_unit: {  } }
    assert_redirected_to processing_unit_url(@processing_unit)
  end

  test "should destroy processing_unit" do
    assert_difference('ProcessingUnit.count', -1) do
      delete processing_unit_url(@processing_unit)
    end

    assert_redirected_to processing_units_url
  end
end
