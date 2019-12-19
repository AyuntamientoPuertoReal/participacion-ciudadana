class IncidenceTypesController < ApplicationController
  layout "admin/admin_layout"

  before_action :set_incidence_type, only: [:edit, :update, :destroy, :increment_order, :decrement_order]
  before_action :set_edit, only: [:new, :edit]
  load_and_authorize_resource

  # GET /incidence_types
  # GET /incidence_types.json
  def index
    @incidence_types = IncidenceType.all.order(:order)
  end

  # GET /incidence_types/new
  def new
    @edit = false
    @proc_unit_incType = []
    @proc_unit_all = ProcessingUnit.all
    @incidence_type = IncidenceType.new
  end

  # GET /incidence_types/1/edit
  def edit
    proc_unit_all_absolute = ProcessingUnit.all
    proc_unit_pi = PuIt.joins(:processing_unit, :incidence_type).where(incidence_type_id: params[:id])
    @processing_unit_pi_array = Array.new

    proc_unit_pi.each do |pr_pi|
      @processing_unit_pi_array += Array(ProcessingUnit.find(pr_pi.processing_unit_id))
    end

    @processing_unit_all = proc_unit_all_absolute - @processing_unit_pi_array
  end

  # POST /incidence_types
  # POST /incidence_types.json
  def create
    @incidence_type = IncidenceType.new(incidence_type_params)

    respond_to do |format|
      if @incidence_type.save
        format.html { redirect_to incidence_types_path, notice: 'Incidence type was successfully created.' }
        format.json { render :index, status: :created, location: @incidence_type }
      else
        format.html { render :new }
        format.json { render json: @incidence_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /incidence_types/1
  # PATCH/PUT /incidence_types/1.json
  def update
    respond_to do |format|
      if @incidence_type.update(incidence_type_params)
        format.html { redirect_to incidence_types_path, notice: 'Incidence type was successfully updated.' }
        format.json { render :index, status: :ok, location: @incidence_type }
      else
        format.html { render :edit }
        format.json { render json: @incidence_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /incidence_types/1
  # DELETE /incidence_types/1.json
  def destroy
    @incidence_type.destroy
    respond_to do |format|
      format.html { redirect_to incidence_types_path, notice: 'Incidence type was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  def increment_order
    @minimum = IncidenceType.minimum(:order).to_i
    actual =  @incidence_type.order
    if actual.to_i > @minimum
      @next_it = IncidenceType.where(order: actual - 1).take!
      @incidence_type.decrement!(:order)
      @next_it.increment!(:order)
    end
    respond_to :js
  end

  def decrement_order
    @maximum = IncidenceType.maximum(:order).to_i
    actual = @incidence_type.order
    if actual.to_i < @maximum
      @previous_it = IncidenceType.where(order: actual + 1).take!
      @incidence_type.increment!(:order)
      @previous_it.decrement!(:order)
    end
    respond_to :js
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_incidence_type
      @incidence_type = IncidenceType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def incidence_type_params
      params.require(:incidence_type).permit(:name, :code, :description)
    end

    def set_edit
      @edit = true
    end
end
