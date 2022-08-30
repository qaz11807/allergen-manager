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
end
