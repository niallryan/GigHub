class ProfilesController < ApplicationController
  def show
    @user = User.find_by_profile_name(params[:id])
    if @user
      @statuses = @user.statuses.order('created_at desc').all
      render action: :show
      @user_event_attendances = @user.user_event_attendances.all
    else
      render file: 'public/404', status: 404, format: [:html]
    end
  end
end
