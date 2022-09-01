class Image < ApplicationRecord
  belongs_to :imagable, polymorphic: true
  has_one_attached :file

  def generate_url!
    update(
      url: file.url,
      thumbnail_url: thumbnail.url
    )
  end

  private

  def thumbnail
    file.variant(resize_to_limit: [50, 50]).processed
  end
end
