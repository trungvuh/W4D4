class SessionsController < ApplicationController
  before_action :require_logged_in, only: [:destroy]
  before_action :require_logged_out, only: [:new, :create]

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if user.nil?
      flash[:errors] = ["Invalid username and password"]
      render :new
    else
      login!(user)
      redirect_to root_url
    end
  end

  def destroy
    if current_user
      logout!
    end
    redirect_to new_session_url
  end

end
