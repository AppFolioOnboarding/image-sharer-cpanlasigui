require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  test 'new' do
    get new_image_path

    assert_response :success
    assert_select 'input[name="image[url]"]'
  end

  test 'create succeeds with valid url' do
    assert_difference 'Image.count', 1 do
      post images_path, params: { image: { url: 'https://image.jpg' } }
    end
    assert_redirected_to image_path(Image.last)
  end

  test 'create fails with invalid url' do
    assert_difference 'Image.count', 0 do
      post images_path, params: { image: { url: 'bad_url' } }
    end
    assert_response :unprocessable_entity
  end

  test 'show' do
    image = Image.create!(url: 'https://goodurl.jpg')

    get image_path(image)

    assert_response :success
    assert_select 'img[class="js-image"]', count: 1
  end

  test 'index' do
    get images_path

    assert_response :success
  end
end
