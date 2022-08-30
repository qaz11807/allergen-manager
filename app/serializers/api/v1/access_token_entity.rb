class Api::V1::AccessTokenEntity < BaseEntity
  expose :token, :expires_in, :refresh_token, :expires_in

  expose :token_type do
    'bearer'
  end

  expose :created_at

  private

  def created_at
    @created_at ||= object[:created_at].to_time.to_i
  end
end
