class UserFriendshipsController < ApplicationController

  def new
    if params[:friend_id]
      @friend = User.where(profile_name: params[:friend_id]).first
      raise ActiveRecord::RecordNotFound if @friend.nil?
      # @user_friendship = current_user.user_friendships.new(friend: @friend)
      @user_friendship = UserFriendship.new(friend: @friend, user: current_user)
    else
      flash[:error] = "Friend Required"
    end

  rescue ActiveRecord::RecordNotFound
    render file: 'public/404', status: :not_found
  end

end
