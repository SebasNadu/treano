require "test_helper"

class TvsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tvs_index_url
    assert_response :success
  end

  test "should get show" do
    get tvs_show_url
    assert_response :success
  end
end
