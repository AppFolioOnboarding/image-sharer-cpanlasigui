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

  def index
    @images = Image.order(created_at: :desc)
  end

  def image_params
    params.require(:image).permit(:url, :tag_list)
  end
end
