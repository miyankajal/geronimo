class ClassSectionsController < ApplicationController
  before_action :set_class_section, only: [:show, :edit, :update, :destroy]

  # GET /class_sections
  def index
    @class_sections = ClassSection.where('school_id = ?', current_user.school_id).order('description')
  end

  # GET /class_sections/1
  def show
  end

  # GET /class_sections/new
  def new
    @class_section = ClassSection.new
  end

  # GET /class_sections/1/edit
  def edit
  end

  # POST /class_sections
  def create
    @class_section = ClassSection.new(class_section_params)

    if @class_section.save
      redirect_to @class_section, notice: 'Class section was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /class_sections/1
  def update
    if @class_section.update(class_section_params)
      redirect_to @class_section, notice: 'Class section was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /class_sections/1
  def destroy
    @class_section.destroy
    redirect_to class_sections_url, notice: 'Class section was successfully destroyed.'
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_class_section
      @class_section = ClassSection.where('school_id = ?', current_user.school_id).find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def class_section_params
      params.require(:class_section).permit(:description, :school_id)
    end
	
end
