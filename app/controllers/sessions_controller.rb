class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    warden.authenticate(:password)
    return render :new, alert: warden.message unless warden.authenticated?
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Logged in' }
    end
  end

  def destroy
    warden.logout
    redirect_to root_url, notice: 'Logged out'
  end
end
