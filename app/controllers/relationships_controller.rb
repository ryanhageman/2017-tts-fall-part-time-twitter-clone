class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @friend = User.find(params[:friend_id])
    @relationship = current_user.relationships.build(friend_id: @friend.id)

    if @relationship.save
      flash[:notice] = "You're now following #{@friend.username}."
      redirect_to profile_path(@friend.id)
    else
      flash[:notice] = "Unable to follow"
      redirect_to profile_path(@friend.id)
    end
  end

  def destroy
    @relationship = current_user.relationships.find(params[:id])
    @relationship.destroy
    @friend = User.find(params[:id])

    flash[:notice] = "No longer following #{@friend.username}"
    redirect_to profile_path(current_user.id)
  end

  private

  def relationship_params
    params.require(:relationship).permit(:user_id, :friend_id)
  end

end
