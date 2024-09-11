# app/models/jwt_denylist.rb
class JwtDenylist < ApplicationRecord
  self.table_name = 'jwt_denylists'
  # You might need to create this table with columns for jti and exp
  validates :jti, presence: true
  validates :exp, presence: true
end
