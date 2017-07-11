require 'bcrypt'

class User::Authenticate
  def initialize(user, password)
    @user = user
    @password = password
  end

  def call
    authenticate
  end

  private

  def authenticate
    BCrypt::Password.new(@user.encrypted_password) == @password
  end
end
