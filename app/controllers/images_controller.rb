class ImagesController < ApplicationController
  protect_from_forgery with: :exception

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(image_params)
    if @image.save
      redirect_to image_path(@image)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @image = Image.find(params[:id])
  end

  def destroy
    Image.destroy(params[:id])
    redirect_to images_path
  end

  def index
    @images = if params[:tag].present?
                Image.tagged_with(params[:tag]).order(created_at: :desc)
              else
                Image.order(created_at: :desc)
              end

    @tags = all_image_tags
  end

  def image_params
    params.require(:image).permit(:url, :tag_list)
  end

  def all_image_tags
    Image.tag_counts.map(&:name)
  end
end
