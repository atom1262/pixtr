class LikeImagesController < ApplicationController

  def create
    @image = find_image
    current_user.like(@image)
    render :change
  end

  def destroy
    @image = find_image
    current_user.unlike(@image)
    render :change
  end

  private

  def find_image
    Image.find(params[:id])
  end
end