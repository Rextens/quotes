require "test_helper"

class CloudControllerTest < ActionDispatch::IntegrationTest
  test "should get cloud" do
    get cloud_cloud_url
    assert_response :success
  end
end
