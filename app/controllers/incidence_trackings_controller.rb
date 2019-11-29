class IncidenceTrackingsController < ApplicationController
  layout "admin/admin_layout"

  before_action :set_incidence_tracking, only: [:edit, :update, :destroy]

  # GET /incidence_trackings
  # GET /incidence_trackings.json
  def index
    @incidence_trackings = IncidenceTracking.all
  end

  # GET /incidence_trackings/new
  def new
    @proc_unit_incType = []
    @proc_unit_all = ProcessingUnit.all
    @incidence_tracking = IncidenceTracking.new
  end

  # GET /incidence_trackings/1/edit
  def edit
    @proc_unit_staff = ProcessingUnit.includes(:processing_unit).where("id = "+params[:id]).all
    @proc_unit_all = ProcessingUnit.includes(:processing_unit).where.not("id = "+params[:id]).all
  end

  # POST /incidence_trackings
  # POST /incidence_trackings.json
  def create
    @incidence_tracking = IncidenceTracking.new(incidence_tracking_params)

    respond_to do |format|
      if @incidence_tracking.save
        format.html { redirect_to incidence_trackings_url, notice: 'Incidence tracking was successfully created.' }
        format.json { render :index, status: :created, location: @incidence_tracking }
      else
        format.html { render :new }
        format.json { render json: @incidence_tracking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /incidence_trackings/1
  # PATCH/PUT /incidence_trackings/1.json
  def update
    respond_to do |format|
      if @incidence_tracking.update(incidence_tracking_params)
        format.html { redirect_to incidence_trackings_url, notice: 'Incidence tracking was successfully updated.' }
        format.json { render :index, status: :ok, location: @incidence_tracking }
      else
        format.html { render :edit }
        format.json { render json: @incidence_tracking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /incidence_trackings/1
  # DELETE /incidence_trackings/1.json
  def destroy
    @incidence_tracking.destroy
    respond_to do |format|
      format.html { redirect_to incidence_trackings_url, notice: 'Incidence tracking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_incidence_tracking
      @incidence_tracking = IncidenceTracking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def incidence_tracking_params
      params.fetch(:incidence_tracking, {})
    end
end
