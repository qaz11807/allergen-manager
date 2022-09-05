# frozen_string_literal: true

class Api::V1::UserController < Api::V1::ApplicationController
  skip_before_action :doorkeeper_authorize!
  before_action :setup_application

  def register
    registration = UserRegistration.call(@application.id, user_params, profile_params)
    return error_response(registration.error.key) if registration.failed?

    serialize_response(:user, registration.result, with_token: true)
  end

  private

  def user_params
    params.permit(:email, :password)
  end

  def profile_params
    params.require(:profile).permit(:name, :birthday, :lang)
  end

  def setup_application
    @application = Doorkeeper::Application.find_by(uid: params[:client_id], secret: params[:client_secret])
    return error_response(:invalid_client) if @application.nil?
  end
end
