class ProcessingUnitsController < ApplicationController
  layout "admin/admin_layout"

  before_action :set_processing_unit, only: [:edit, :update, :destroy, :assign_incidence_types, :unassign_incidence_types]
  before_action :set_edit, only: [:new, :edit]
  load_and_authorize_resource

  # GET /processing_units
  # GET /processing_units.json
  def index
    @processing_units = ProcessingUnit.all
  end

  # GET /processing_units/new
  def new
    @edit = false
    @staff_ut = []
    @staff_all = Staff.all
    @incidence_type_ut = []
    @incidence_type_all = IncidenceType.all
    @processing_unit = ProcessingUnit.new
  end

  # GET /processing_units/1/edit
  def edit
    staff_all_absolute = Staff.all
    staff_ps = PuStaff.joins(:staff, :processing_unit).where(processing_unit_id: params[:id])
    @staff_ps_array = Array.new

    staff_ps.each do |st_ps|
      @staff_ps_array += Array(Staff.find(st_ps.staff_id))
    end

    @staff_all = staff_all_absolute - @staff_ps_array


    incidence_type_all_absolute = IncidenceType.all
    incidence_type_ut = PuIt.joins(:incidence_type, :processing_unit).where(processing_unit_id: params[:id])
    @incidence_type_ut_array = Array.new

    incidence_type_ut.each do |inc_ut|
      @incidence_type_ut_array += Array(IncidenceType.find(inc_ut.incidence_type_id))
    end

    @incidence_type_all = incidence_type_all_absolute - @incidence_type_ut_array
  end

  # POST /processing_units
  # POST /processing_units.json
  def create
    @processing_unit = ProcessingUnit.new(processing_unit_params)

    respond_to do |format|
      if @processing_unit.save
        format.html { redirect_to processing_units_path, notice: 'Processing unit was successfully created.' }
        format.json { render :index, status: :created, location: @processing_unit }
      else
        format.html { render :new }
        format.json { render json: @processing_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /processing_units/1
  # PATCH/PUT /processing_units/1.json
  def update
    respond_to do |format|
      if @processing_unit.update(processing_unit_params)
        format.html { redirect_to processing_units_path, notice: 'Processing unit was successfully updated.' }
        format.json { render :index, status: :ok, location: @processing_unit }
      else
        format.html { render :edit }
        format.json { render json: @processing_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /processing_units/1
  # DELETE /processing_units/1.jsonbefore_actionedit, only: [:new, :edit]
  def destroy
    @processing_unit.destroy
    respond_to do |format|
      format.html { redirect_to processing_units_url, notice: 'Processing unit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def assign_incidence_types
    PuIt.find_or_create_by(processing_unit: @processing_unit, incidence_type: IncidenceType.find_by(id: params[:available_incidence]))
    respond_to :js
  end

  def unassign_incidence_types
    PuIt.find_or_create_by(processing_unit: @processing_unit, incidence_type: IncidenceType.find_by(id: params[:assigned_incidence])).destroy
    respond_to :js
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_processing_unit
      @processing_unit = ProcessingUnit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def processing_unit_params
      params.require(:processing_unit).permit(:code, :description)
    end

    def set_edit
      @edit = true
    end
end
