require 'test_helper'

class IncidencesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get incidences_index_url
    assert_response :success
  end

  test "should get show" do
    get incidences_show_url
    assert_response :success
  end

end
