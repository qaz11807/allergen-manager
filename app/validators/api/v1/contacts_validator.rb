module Api
  module V1
    class ContactsValidator < BasicValidator
      def index
        param! :page,     Integer, default: 1
        param! :per_page, Integer
      end

      def create
        param! :name,         String
        param! :phone,        String
        param! :description,  String
      end

      def update
        param! :name,         String
        param! :phone,        String
        param! :description,  String
      end

      def update_order
        param! :contact_ids, Array do |array, index|
          array.param! index, Integer, required: true
        end
      end

      def bulk_destroy
        param! :contact_ids, Array do |array, index|
          array.param! index, Integer, required: true
        end
      end
    end
  end
end
