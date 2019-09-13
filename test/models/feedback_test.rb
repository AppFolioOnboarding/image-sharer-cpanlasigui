require 'test_helper'

class FeedbackTest < ActiveSupport::TestCase
  test 'is valid feedback' do
    image = Feedback.new(name: 'test name', comment: 'good')
    assert_predicate image, :valid?
  end

  test 'is invalid without name' do
    image = Feedback.new(comment: 'good')
    refute_predicate image, :valid?
  end

  test 'is invalid without comment' do
    image = Feedback.new(name: 'test name')
    refute_predicate image, :valid?
  end
end
