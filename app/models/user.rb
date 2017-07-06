class User < ApplicationRecord

  def authenticate(password)
    BCrypt::Password.new(encrypted_password) == password
  end

  def generate_session_token!
    self.session_token = Digest::SHA1.hexdigest("#{Time.now}-#{self.id}-#{self.updated_at}")
    self.save
    self.session_token
  end
end
