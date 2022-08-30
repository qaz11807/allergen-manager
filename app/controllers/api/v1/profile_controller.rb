# frozen_string_literal: true

class Api::V1::ProfileController < Api::V1::ApplicationController
  def show
    serialize_response(:profile, current_user.profile)
  end

  def update
    current_user.profile.update!(profile_params)

    serialize_response(:profile, current_user.profile)
  end

  private

  def profile_params
    params.permit(:phone, :lang, :name, :birthday)
  end
end
