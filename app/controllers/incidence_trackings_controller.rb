class IncidenceTrackingsController < ApplicationController
  layout "admin/admin_layout"

  before_action :set_incidence, only: [:new, :edit, :update, :destroy, :create]
  before_action :new, only: [:create]
  before_action :edit, only: [:update]
  load_and_authorize_resource

  # GET /incidence/:incidence_id/incidence_trackings/new
  def new
    @incidence_tracking = IncidenceTracking.new({:incidence_id => @incidence.id})
    @url_form = "/incidence/"+params[:incidence_id]+"/incidence_trackings"
    @method_form = "POST"
  end

  # GET /incidence/1/incidence_trackings/1/edit
  def edit
    @incidence_tracking = IncidenceTracking.where(:incidence_id => params[:incidence_id], :id => params[:id]).first
    @url_form = "/incidence/"+params[:incidence_id]+"/incidence_trackings/"+params[:id]
    @method_form = "PATCH"
  end


  def create
    @incidence_tracking = IncidenceTracking.new(incidence_tracking_params)
    @incidence_tracking.incidence_id = @incidence.id
    @incidence_tracking.staff_id = current_user.id
    @incidence_tracking.processing_units = ""

    pro_ut_staff = PuStaff.where(:staff_id => current_user.id)

    pro_ut_staff.each_with_index do |pro_ut_staff, index|
      @incidence_tracking.processing_units += pro_ut_staff.code

      if pro_ut_staff.size < index
        @incidence_tracking.processing_units += "/"
      end
    end

    incidence_tracking_status = IncidenceTracking.where(:incidence_id => @incidence.id).select(:status, :created_at).order("created_at DESC").first
    
    if incidence_tracking_status.nil?
      @incidence_tracking.previous_status = 1
    else
      @incidence_tracking.previous_status = incidence_tracking_status.status
    end 

    respond_to do |format|
      if @incidence_tracking.save
        format.html { redirect_to incidence_path(@incidence) }
        format.json { render :index, status: :created, location: @incidence_tracking }
      else
        format.html { render :new }
        format.json { render json: @incidence_tracking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /incidence/1/incidence_trackings/1
  # PATCH/PUT /incidence/1/incidence_trackings/1.json
  def update
    respond_to do |format|
      if @incidence_tracking.update(incidence_tracking_params)
        format.html { redirect_to incidence_path(@incidence) }
        format.json { render :index, status: :ok, location: @incidence_tracking }
      else
        format.html { render :edit }
        format.json { render json: @incidence_tracking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /incidence/1/incidence_trackings/1
  # DELETE /incidence/1/incidence_trackings/1.json
  def destroy
    @incidence_tracking.destroy
    respond_to do |format|
      format.html { redirect_to incidence_path(@incidence), notice: 'Incidence tracking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_incidence
    @incidence = Incidence.find(params[:incidence_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def incidence_tracking_params
    params.require(:incidence_tracking).permit(:incidence_id, :status, :message)
  end
end
