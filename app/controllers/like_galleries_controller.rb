class LikeGalleriesController < ApplicationController

  def create
    gallery = find_gallery
    current_user.like(gallery)
    redirect_to gallery
  end

  def destroy
    gallery = find_gallery
    current_user.unlike(gallery)
    redirect_to gallery
  end

  private

  def find_gallery
    Gallery.find(params[:id])
  end
end