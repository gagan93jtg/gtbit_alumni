class AddStateAndAnsweredToPosts < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      t.string :state, default: 'active'
      t.boolean :is_answered, default: false
    end
    add_index :posts, :state
    add_index :posts, :is_answered
  end
end
