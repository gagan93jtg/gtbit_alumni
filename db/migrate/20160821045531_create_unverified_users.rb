class CreateUnverifiedUsers < ActiveRecord::Migration
  def change
    create_table :unverified_users do |t|
      t.string  :first_name, default: ''
      t.string  :last_name, default: ''
      t.string  :email, default: ''
      t.string  :batch, default: ''

      t.timestamps
    end
  end
end
