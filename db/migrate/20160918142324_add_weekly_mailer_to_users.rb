class AddWeeklyMailerToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.boolean :receive_weekly_mailer, default: true
    end
  end
end
