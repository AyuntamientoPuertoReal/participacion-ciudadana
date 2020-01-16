class InterestPointsController < ApplicationController
  layout "admin/admin_layout"
  
  before_action :set_interest_point, only: [:edit, :update, :destroy]

  # GET /interest_points
  # GET /interest_points.json
  def index
    @interest_points = InterestPoint.all
  end

  # GET /interest_points/new
  def new
    @interest_point = InterestPoint.new
    @src_map = "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d10783.67073104068!2d-6.185858228210201!3d36.529886059768806!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0xd0dcc2483d623a7%3A0x71b44bb8c8947118!2s11510%20Puerto%20Real%2C%20C%C3%A1diz!5e0!3m2!1ses!2ses!4v1579166904692!5m2!1ses!2ses"
  end

  # GET /interest_points/1/edit
  def edit
    @src_map = "https://maps.google.com/maps?q="+@interest_point.latitude+","+@interest_point.longitude+"&t=&z=13&ie=UTF8&iwloc=&output=embed"
  end

  # POST /interest_points
  # POST /interest_points.json
  def create
    @interest_point = InterestPoint.new(interest_point_params)

    respond_to do |format|
      if @interest_point.save
        format.html { redirect_to @interest_point, notice: 'Interest point was successfully created.' }
        format.json { render :show, status: :created, location: @interest_point }
      else
        format.html { render :new }
        format.json { render json: @interest_point.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /interest_points/1
  # PATCH/PUT /interest_points/1.json
  def update
    respond_to do |format|
      if @interest_point.update(interest_point_params)
        format.html { redirect_to @interest_point, notice: 'Interest point was successfully updated.' }
        format.json { render :show, status: :ok, location: @interest_point }
      else
        format.html { render :edit }
        format.json { render json: @interest_point.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interest_points/1
  # DELETE /interest_points/1.json
  def destroy
    @interest_point.destroy
    respond_to do |format|
      format.html { redirect_to interest_points_url, notice: 'Interest point was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interest_point
      @interest_point = InterestPoint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def interest_point_params
      params.require(:interest_point).permit(:name, :description, :image_url, :latitude, :longitude)
    end
end
