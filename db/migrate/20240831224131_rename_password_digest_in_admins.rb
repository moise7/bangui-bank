class RenamePasswordDigestInAdmins < ActiveRecord::Migration[7.1]
  def change
    rename_column :admins, :password_digest, :encrypted_password
  end
end