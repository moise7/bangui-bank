class UserAuthenticationService
  def self.create_new_token(user)
    jti = SecureRandom.uuid
    payload = { user_id: user.id, jti: jti }
    token = JwtService.encode(payload)
    user.update!(jti: jti)
    token
  end
end
