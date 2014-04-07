class ImagesController < ApplicationController
  def new
    find_gallery
    @image = Image.new
  end

  def create
    find_gallery
    @image = @gallery.images.new(image_params)
    if @image.save
      redirect_to @gallery
    else
      render :new # <-- redirect loses info, render will keep it 
    end
  end

  def show
    @image = Image.find(params[:id])
    @comment = Comment.new
    @comments = @image.comments.recent.page(params[:page]).per(2).includes(:user)
    @tags = @image.tags
  end

  def edit
    find_image
    @groups = current_user.groups
  end

  def update
    find_image
    if @image.update(image_params)
      redirect_to @image
    else 
      @groups = current_user.groups
      render :edit
    end
  end

  def destroy
    find_image
    image.destroy
    redirect_to image.gallery
  end

  private
  
  def find_image
   @image = current_user.images.find(params[:id])
  end

  def find_gallery
    @gallery = current_user.galleries.find(params[:id])
  end

  def image_params
    params.require(:image).permit(
      :name,
      :url,
      :description,
      :tag_list,
      group_ids: []
    )
  end
end
