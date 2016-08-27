class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.string  :first_name, default: ''
      t.string  :last_name, default: ''
      t.string  :username, default: ''
      t.string  :gender, default: ''
      t.text    :bio

      t.string  :batch, default: ''
      t.string  :company, default: ''
      t.string  :job_type, default: ''
      t.string  :designation, default: ''
      t.integer :experience_in_years, default: 0

      t.string  :phone, default: ''
      t.string  :fb_link, default: ''
      t.string  :twitter_link, default: ''
      t.string  :linked_in_link, default: ''

      t.boolean :is_admin, default: false
      t.boolean :is_moderator, default: false
      t.boolean :is_active, default: true
      t.integer :reputation, default: 0

      t.timestamps
    end
    add_index :users, :first_name
    add_index :users, :last_name
    add_index :users, :phone
  end
end
