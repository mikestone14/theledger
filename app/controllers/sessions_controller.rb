class SessionsController < ApplicationController
  before_action :redirect_if_authenticated, only: [:new]

  def new; end

  def create
    user = User.where("lower(email) = ?", lower_email).first

    if user&.authenticate(login_params.fetch(:password))
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      render :new
    end
  end

  private

  def login_params
    params.require(:login).permit(:email, :password)
  end

  def lower_email
    login_params.fetch(:email).downcase
  end

  def redirect_if_authenticated
    redirect_to dashboard_path if current_user
  end
end
