class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}, you are logged in!"
      redirect_to '/user/dashboard'
    else
      flash[:error] = 'Sorry, your credentials are bad.'
      redirect_to root_path
    end
  end
end
