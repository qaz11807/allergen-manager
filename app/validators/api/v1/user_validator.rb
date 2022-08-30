module Api
  module V1
    class UserValidator < BasicValidator
      def register
        param! :email,           String,  required: true
        param! :password,        String,  required: true
        param! :client_id,       String,  required: true
        param! :client_secret,   String,  required: true
        param! :profile,         Hash,    required: true do |p|
          p.param! :name,          String,  required: true
          p.param! :birthday,      Date,  required: true
          p.param! :lang,          String
          p.param! :phone,         String
        end
      end
    end
  end
end
