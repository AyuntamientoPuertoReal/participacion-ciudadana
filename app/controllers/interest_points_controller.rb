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
  end

  # GET /interest_points/1/edit
  def edit
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
