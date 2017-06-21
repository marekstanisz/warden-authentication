require 'bcrypt'

class User::Create
  include Virtus.model
  include ActiveModel::Validations

  attribute :email
  attribute :password
  attribute :encrypted_password
  attribute :password_confirmation

  def call
    validate!
    encrypt_password
    save_user
  rescue ActiveModel::RecordInvalid
    raise CommonErrors::CommandValidationFailed
  end

  private

  def encrypt_password
    @encrypted_password = BCrypt::Password.new(password_hash)
  end

  def save_user
    User.create(attributes)
  end
end
