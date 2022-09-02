class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :validatable

  validates :email, format: URI::MailTo::EMAIL_REGEXP
  validates_associated :profile

  has_one :profile, dependent: :destroy
  has_many :access_tokens, class_name: 'Doorkeeper::AccessToken',
                           foreign_key: 'resource_owner_id',
                           dependent: :destroy
  # has_many :contacts, dependent: :destroy
  has_many :allergens, dependent: :destroy
  has_many :medicines, dependent: :destroy
  has_many :contacts, dependent: :destroy

  class << self
    def authenticate(email, password)
      user = User.find_for_authentication(email: email)
      user&.valid_password?(password) ? user : nil
    end
  end

  def generate_access_token(app_id, scopes = '')
    access_tokens.create(
      application_id: app_id,
      refresh_token: generate_refresh_token,
      expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
      scopes: scopes
    )
  end

  private

  def generate_refresh_token
    loop do
      token = SecureRandom.hex(32)
      break token unless Doorkeeper::AccessToken.exists?(refresh_token: token)
    end
  end
end
