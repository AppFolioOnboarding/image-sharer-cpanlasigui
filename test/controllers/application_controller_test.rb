require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test 'should get home' do
    get root_path
    assert_select 'body', 'Hello'
    assert_response :success
  end
end
