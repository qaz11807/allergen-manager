class Contact < ApplicationRecord
  belongs_to :user

  scope :by_order, -> { order(order: :asc) }

  class << self
    def update_orders(sorted_ids)
      update_data = sorted_ids.map.with_index do |contact_id, index|
        { id: contact_id, order: index }
      end
      upsert_all(update_data)
    end
  end
end
