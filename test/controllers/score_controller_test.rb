require "test_helper"

class ScoreControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get score_list_url
    assert_response :success
  end
end
