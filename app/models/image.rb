class Image < ApplicationRecord
  belongs_to :imagable, polymorphic: true
  has_one_attached :file

  before_save :generate_url

  def generate_url
    self.url = image_file.url
    self.thumbnail_url = thumbnail.url
    save
  end

  private

  def thumbnail
    image_file.variant(resize_to_limit: [100, 100]).processed
  end
end
