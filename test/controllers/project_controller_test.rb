require 'test_helper'

class ProjectControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get project_home_url
    assert_response :success
  end

  test "should get about" do
    get project_about_url
    assert_response :success
  end

  test "should get contact" do
    get project_contact_url
    assert_response :success
  end

end
