class StaffsController < ApplicationController
  layout "admin/admin_layout"

  before_action :set_staff, only: [:edit, :update, :destroy, :assign_pu_staff, :unassign_pu_staff]
  before_action :set_processing_units, only: [:edit, :update]
  before_action :set_edit, only: [:new, :edit]
  load_and_authorize_resource

  # GET /staffs
  # GET /staffs.json
  def index
    @staffs = Staff.search(params[:search_code], params[:search_name], params[:search_ut])
    
    ut_code_tmp = ProcessingUnit.all.select(:id, :code)
    @ut_code = {0 => t("tags.indeterminate")}

    ut_code_tmp.each do |ut_code_ind|
      @ut_code[ut_code_ind.id] = ut_code_ind.code
    end

  end

  # GET /staffs/new
  def new
    @edit = false

    @proc_unit_staff = []
    @proc_unit_all = ProcessingUnit.all
    @staff = Staff.new
  end

  # GET /staffs/1/edit
  def edit
    processing_unit_all_absolute = ProcessingUnit.all
    processing_unit_ps = PuStaff.joins(:processing_unit, :staff).where(staff_id: params[:id])
    @processing_unit_ps_array = Array.new

    processing_unit_ps.each do |pr_ps|
      @processing_unit_ps_array += Array(ProcessingUnit.find(pr_ps.processing_unit_id))
    end

    @processing_unit_all = processing_unit_all_absolute - @processing_unit_ps_array
  end

  # POST /staffs
  # POST /staffs.json
  def create
    @staff = Staff.new(staff_params)

    respond_to do |format|
      if @staff.save
        format.html { redirect_to staffs_path, notice: 'Staff was successfully created.' }
        format.json { render :index, status: :created, location: @staff }
      else
        format.html { render :new }
        format.json { render json: @staff.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /staffs/1
  # PATCH/PUT /staffs/1.json
  def update
    respond_to do |format|
      if @staff.update(staff_params)
        format.html { redirect_to staffs_path, notice: 'Staff was successfully updated.' }
        format.json { render :index, status: :ok, location: @staff }
      else
        format.html { render :edit }
        format.json { render json: @staff.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /staffs/1
  # DELETE /staffs/1.json
  def destroy
    @staff.destroy
    respond_to do |format|
      format.html { redirect_to staffs_path, notice: 'Staff was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  def assign_staff
    PuStaff.find_or_create_by(staff: @staff, processing_unit: ProcessingUnit.find_by(id: params[:available_pu]))
    respond_to :js
  end

  def unassign_staff
    PuStaff.find_or_create_by(staff: @staff, processing_unit: ProcessingUnit.find_by(id: params[:assigned_pu])).destroy
    respond_to :js
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_staff
      @staff = Staff.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def staff_params
      if params[:staff][:password].blank? && params[:staff][:password_confirmation].blank?
        params.require(:staff).permit(:full_name, :username, :email, :is_web_editor, :can_publish, :description, :role_id)
      else
      params.require(:staff).permit(:full_name, :username, :email, :password, :password_confirmation, :is_web_editor, :can_publish, :description, :role_id)
      end
    end

    def set_processing_units
      @proc_unit_staff = ProcessingUnit.joins(:staff).select(:id, :code)
      @proc_unit_all = ProcessingUnit.left_outer_joins(:staff).select(:id, :code)
    end

    def set_edit
      @edit = true
    end

end
