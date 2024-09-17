class AddDeviseToAdmins < ActiveRecord::Migration[6.1]
  def change
    change_table :admins do |t|
      # Check if columns already exist before adding
      unless column_exists?(:admins, :reset_password_token)
        t.string :reset_password_token
      end

      unless column_exists?(:admins, :reset_password_sent_at)
        t.datetime :reset_password_sent_at
      end

      unless column_exists?(:admins, :remember_created_at)
        t.datetime :remember_created_at
      end

      unless column_exists?(:admins, :sign_in_count)
        t.integer :sign_in_count, default: 0, null: false
      end

      unless column_exists?(:admins, :current_sign_in_at)
        t.datetime :current_sign_in_at
      end

      unless column_exists?(:admins, :last_sign_in_at)
        t.datetime :last_sign_in_at
      end

      unless column_exists?(:admins, :current_sign_in_ip)
        t.string :current_sign_in_ip
      end

      unless column_exists?(:admins, :last_sign_in_ip)
        t.string :last_sign_in_ip
      end
    end

    # Add index if it does not already exist
    unless index_exists?(:admins, :reset_password_token)
      add_index :admins, :reset_password_token, unique: true
    end
  end
end
