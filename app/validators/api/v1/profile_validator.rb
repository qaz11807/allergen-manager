module Api
  module V1
    class ProfileValidator < BasicValidator
      def update
        param! :name,          String
        param! :birthday,      Date
        param! :lang,          String
        param! :phone,         String
      end
    end
  end
end
