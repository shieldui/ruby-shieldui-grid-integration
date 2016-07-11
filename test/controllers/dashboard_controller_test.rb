require 'test_helper'

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get default" do
    get dashboard_default_url
    assert_response :success
  end

end
