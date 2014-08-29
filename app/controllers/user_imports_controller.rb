class UserImportsController < ApplicationController
  def new
    @user_import = UserImport.new
  end

  def create
    @user_import = UserImport.new(params[:user_import])
    if @user_import.save
      redirect_to root_url, notice: "Imported users successfully."
    else
      render :new
    end
  end
end