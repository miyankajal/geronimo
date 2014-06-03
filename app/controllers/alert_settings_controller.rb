class AlertSettingsController < ApplicationController
  
  # GET /alert_settings/1/edit
  def edit
	@alert_setting = AlertSetting.where('school_id = ?', current_user.school_id).first
  end

  # PATCH/PUT /alert_settings/1
  def update
	@alert_setting = AlertSetting.where('school_id = ?', current_user.school_id).first
	
    if @alert_setting.update(alert_setting_params)
      redirect_to edit_alert_setting_path(), notice: 'Alert settings were successfully updated.'
    else
      render action: 'edit'
    end
  end
  
  private
  
  def alert_setting_params
      params.require(:alert_setting).permit(:default_points, :min_points_required, :send_auto_email, :max_warnings_before_email_alert, :min_points_for_penalty, :repetition_of_mistake_before_email, :penalty_carried_over, :school_id)
  end

end
