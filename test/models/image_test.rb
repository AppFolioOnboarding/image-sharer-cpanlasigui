require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  test 'is valid image' do
    image = Image.new(url: 'https://image.jpg')
    assert_predicate image, :valid?
  end

  test 'invalid with bad url' do
    image = Image.new(url: 'image.jpg')
    refute_predicate image, :valid?
    assert_equal ['Not an image url'], image.errors.messages[:url]

    image = Image.new(url: 'https://image')
    refute_predicate image, :valid?
    assert_equal ['Not an image url'], image.errors.messages[:url]
  end

  test 'accepts tags' do
    image = Image.new(url: 'https://image.jpg')
    image.tag_list.add('test')

    assert_predicate image, :valid?
  end
end
