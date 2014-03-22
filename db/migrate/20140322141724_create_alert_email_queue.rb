class CreateAlertEmailQueue < ActiveRecord::Migration
  def change
    create_table :alert_email_queues do |t|
      t.integer :alert_id
      t.integer :user_id
    end
  end
end
