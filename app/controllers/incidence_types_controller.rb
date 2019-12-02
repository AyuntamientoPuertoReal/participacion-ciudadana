class IncidenceTypesController < ApplicationController
  layout "admin/admin_layout"

  before_action :set_incidence_type, only: [:edit, :update, :destroy]

  # GET /incidence_types
  # GET /incidence_types.json
  def index
    @incidence_types = IncidenceType.all
  end

  # GET /incidence_types/new
  def new
    @proc_unit_incType = []
    @proc_unit_all = ProcessingUnit.all
    @incidence_type = IncidenceType.new
  end

  # GET /incidence_types/1/edit
  def edit
    @proc_unit_incType = ProcessingUnit.includes(:incidence_type).where("id = "+params[:id]).all
    @proc_unit_all = ProcessingUnit.includes(:incidence_type).where.not("id = "+params[:id]).all
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
    end
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
end
