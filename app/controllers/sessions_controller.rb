class SessionsController < ApplicationController
  def new
    flash.now.alert = warden.message if warden.message.present?
    render 'new'
  end

  def create
    warden.authenticate!(:password)
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Logged in' }
    end
  end

  def destroy
    warden.logout
    redirect_to root_url, notice: 'Logged out'
  end
end
