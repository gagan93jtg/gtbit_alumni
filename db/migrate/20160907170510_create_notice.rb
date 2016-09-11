class CreateNotice < ActiveRecord::Migration
  def change
    create_table :notices do |t|
     t.string :notice_text, default: ''
     t.string :notice_url, default: ''
     t.timestamps
    end
  end
end
