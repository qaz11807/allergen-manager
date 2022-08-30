# frozen_string_literal: true

module MockHelper
  def mock_account
    @app = Doorkeeper::Application.create(name: 'test-app', redirect_uri: 'https://redirect.uri', scopes: 'kdan')
    @user = FactoryBot.create(:user)

    access_token = @user.access_tokens.create(
      application_id: @app.id,
      refresh_token: generate_refresh_token,
      expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
      scopes: @app.scopes
    )
    @token = access_token.token
  end

  private

  def generate_refresh_token
    loop do
      token = SecureRandom.hex(32)
      break token unless Doorkeeper::AccessToken.exists?(refresh_token: token)
    end
  end
end
