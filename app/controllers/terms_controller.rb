require "studentInitPoints"

class TermsController < ApplicationController
  before_action :set_term, only: [:show, :edit, :update, :destroy]

  # GET /terms
  def index
    @terms = Term.where('school_id = ?', current_user.school_id).order('term_from DESC')
  end

  # GET /terms/1
  def show
  end

  # GET /terms/new
  def new
    @term = Term.new
  end

  # GET /terms/1/edit
  def edit
  end

  # POST /terms
  def create
    @term = Term.new(term_params)

    if @term.save
	  @prev_term = Term.select('id, term_from, term_to').where('term_from < ? AND school_id = ?', @term.term_from, current_user.school_id).order('term_from DESC').first
	  Resque.enqueue_at(@term.term_from, StudentInitPoints, @prev_term)
	  Resque.remove_delayed(StudentInitPoints, @prev_term)
      redirect_to @term, notice: 'Term was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /terms/1
  def update
    if @term.update(term_params)
      redirect_to @term, notice: 'Term was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /terms/1
  def destroy
    
	# Destroy all the student points related to the term if only default points have been assigned to the students
	@student_point = StudentPoint.joins(:point).where("student_points.created_at >= ? AND student_points.created_at < ? AND school_id = ?", @term.term_from, @term.term_to, current_user.school_id)
	if @student_point.count == 2
		@student_point.delete_all
		@term.destroy
		
		redirect_to terms_url, notice: 'Term was successfully destroyed.'
	else 
		redirect_to terms_url, notice: 'Unable to destroy the Term as points were assigned to students.'
	end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_term
      @term = Term.where('school_id = ?', current_user.school_id).find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def term_params
      params.require(:term).permit(:name, :term_from, :term_to, :school_id)
    end
end
