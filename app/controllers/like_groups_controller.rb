class LikeGroupsController < ApplicationController

  def create
    @group = find_group
    current_user.like(@group)
  end

  def destroy
    @group = find_group
    current_user.unlike(@group)
  end

  private

  def find_group
    Group.find(params[:id])
  end
end