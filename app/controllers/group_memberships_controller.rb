class GroupMembershipsController < ApplicationController

  def create
    @group = join_group
    current_user.join(@group)
    render :change
  end

  def destroy
    @group = join_group
    current_user.leave(@group)
    render :change
  end

  private

  def join_group
    Group.find(params[:id])
  end
end