class Profile < ApplicationRecord
  belongs_to :user

  validates :name, presence: true

  validates :birthday, presence: true
  validate :birthday_validate

  validates :phone, numericality: true, allow_nil: true

  enum lang: { 'en' => 0, 'zh-TW' => 1 }, _default: 'en'

  private

  def birthday_validate
    errors.add(:birthday, ' must earlier than today') if birthday >= Time.now
  end
end
