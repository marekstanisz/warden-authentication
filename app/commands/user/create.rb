require 'bcrypt'

class User::Create
  include Virtus.model
  include ActiveModel::Validations

  attribute :email, String
  attribute :encrypted_password, String
  attribute :password, String
  attribute :password_confirmation, String

  validates :password, confirmation: true
  validates :password, length: { minimum: 8 }

  attr_reader :user

  def call
    validate!
    encrypt_password
    save_user
  end

  private

  def encrypt_password
    @encrypted_password = BCrypt::Password.create(password)
  end

  def save_user
    @user = User.create(attributes.except(:password, :password_confirmation))
  end
end
