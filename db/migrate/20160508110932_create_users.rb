class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.string  :first_name
      t.string  :last_name
      t.string  :urlkey
      t.string  :phone
      t.string  :gender
      t.boolean :is_admin, default: false
      t.boolean :is_trusted, default: false

      t.string  :batch
      t.string  :job_type
      t.string  :designation
      t.string  :company
      t.integer :experience_in_years, default: 0

      t.timestamps
    end
    add_index :users, :first_name
    add_index :users, :last_name
    add_index :users, :phone
  end
end
