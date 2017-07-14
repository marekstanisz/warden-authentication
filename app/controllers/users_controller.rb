class UsersController < ApplicationController
  def new
    render :new
  end

  def create
    command = User::Create.new(user_params)
    command.call
    warden.set_user(command.user)
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Signed up and logged in' }
    end
  rescue ActiveModel::ValidationError
    render :new
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
