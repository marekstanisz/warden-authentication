require 'bcrypt'

class User::Create
  include Virtus.model
  include ActiveModel::Validations

  attribute :email
  attribute :encrypted_password
  attribute :password
  attribute :password_confirmation

  validates :password, confirmation: true
  validates :password, length: { minimum: 8 }

  def call
    validate!
    encrypt_password
    save_user
  rescue ActiveModel::ValidationError
    raise CommonErrors::CommandValidationFailed
  end

  private

  def encrypt_password
    @encrypted_password = BCrypt::Password.create(password)
  end

  def save_user
    User.create(attributes.except(:password, :password_confirmation))
  end
end
