class GroupsController < ApplicationController
  before_action :authorize, except: [:show]

  def index
    @groups = current_user.groups
  end

  def show
    @group = Group.find(params[:id])
    @images = @group.images.includes(gallery: [:user])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      current_user.join @group 
      redirect_to @group
    else
      render :new
    end
  end

  private

  def group_params
    params.require(:group).permit(
      :name,
      :description
      )
  end
end