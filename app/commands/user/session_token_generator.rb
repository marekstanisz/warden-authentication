require 'bcrypt'

class User::SessionTokenGenerator
  def initialize(user)
    @user = user
  end

  def call
    generate_and_save_session_token
  end

  private

  def generate_and_save_session_token
    @user.update(session_token: session_token)
    session_token
  end

  def session_token
    @session_token ||= Digest::SHA1.hexdigest("#{Time.now}-#{@user.id}-#{@user.updated_at}")
  end
end
