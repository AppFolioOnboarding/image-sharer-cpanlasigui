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

  test 'delete successful' do
    cat_image = Image.create!(url: 'https://goodurl1.jpg', tag_list: 'cat')
    dog_image = Image.create!(url: 'https://goodurl2.jpg', tag_list: 'dog')

    assert_difference 'Image.count', -1 do
      delete image_path(cat_image)
    end
    assert_redirected_to images_path
    assert Image.exists?(dog_image.id)
    refute Image.exists?(cat_image.id)
  end

  test 'index images without tags' do
    image1 = Image.create!(url: 'https://goodurl1.jpg')
    image2 = Image.create!(url: 'https://goodurl2.jpg')

    get images_path

    assert_response :success
    assert_select 'img[class="index-image"]' do |images|
      assert_equal image2.url, images[0]['src']
      assert_equal image1.url, images[1]['src']
    end
  end

  test 'index images with tags' do
    cat_image = Image.create!(url: 'https://goodurl1.jpg', tag_list: 'cat')
    Image.create!(url: 'https://goodurl2.jpg', tag_list: 'dog')

    get images_path(tag: 'cat')

    assert_response :success
    assert_select 'img[class="index-image"]' do |images|
      assert_equal 1, images.length
      assert_equal cat_image.url, images[0]['src']
    end
    assert_select 'a[class="js-index-link"]', count: 2
    assert_select 'a[href="/images?tag=cat"]', count: 1
    assert_select 'a[href="/images?tag=dog"]', count: 1
  end

  test 'index tag with no related images' do
    Image.create!(url: 'https://goodurl1.jpg', tag_list: 'cat')
    Image.create!(url: 'https://goodurl2.jpg', tag_list: 'dog')

    get images_path(tag: 'lizard')

    assert_response :success
    assert_select 'img[class="index-image"]', count: 0
  end
end
