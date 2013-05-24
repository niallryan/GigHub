class WelcomeController < ApplicationController
  def home
    @users = User.search(params[:search_query])
  end
end
