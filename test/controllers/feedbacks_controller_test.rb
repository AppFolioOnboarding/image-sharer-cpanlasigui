require 'test_helper'

class FeedbacksControllerTest < ActionDispatch::IntegrationTest
  test 'create succeeds with name and comments' do
    assert_difference 'Feedback.count', 1 do
      post api_feedbacks_path, params: { feedback: { name: 'test name', comment: 'good' } }
    end
    assert_response :ok
  end

  test 'create fails without comment' do
    assert_difference 'Feedback.count', 0 do
      post api_feedbacks_path, params: { feedback: { name: 'no comment' } }
    end
    assert_response :unprocessable_entity
  end

  test 'create fails without name' do
    assert_difference 'Feedback.count', 0 do
      post api_feedbacks_path, params: { feedback: { comment: 'no name' } }
    end
    assert_response :unprocessable_entity
  end
end
