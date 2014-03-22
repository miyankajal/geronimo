class CreateAlertSettings < ActiveRecord::Migration
  def change
    create_table :alert_settings do |t|
      t.integer :default_points
      t.integer :min_points_required
      t.boolean :send_auto_email
      t.integer :max_warnings_before_email_alert
      t.integer :min_points_for_penalty
      t.integer :repetition_of_mistake_before_email
      t.integer :penalty_carried_over
    end
  end
end
