class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def warden
    request.env['warden']
  end

  def current_user
    warden.user
  end
  helper_method :current_user
end
