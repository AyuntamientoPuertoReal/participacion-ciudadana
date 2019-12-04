class StaffsController < ApplicationController
  layout "admin/admin_layout"

  before_action :set_staff, only: [:edit, :update, :destroy]
  before_action :set_processing_units, only: [:edit, :update]

  # GET /staffs
  # GET /staffs.json
  def index
    @staffs = Staff.all
  end

  # GET /staffs/new
  def new
    @proc_unit_staff = []
    @proc_unit_all = ProcessingUnit.all
    @staff = Staff.new
  end

  # GET /staffs/1/edit
  def edit
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
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_staff
      @staff = Staff.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def staff_params
      params.require(:staff).permit(:full_name, :username, :email, :password, :password_confirmation, :is_web_editor, :can_publish, :description)
    end

    def set_processing_units
      @proc_unit_staff = ProcessingUnit.joins(:staff).select(:id, :code)
      @proc_unit_all = ProcessingUnit.left_outer_joins(:staff).select(:id, :code)
    end
end
