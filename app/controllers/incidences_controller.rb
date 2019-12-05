class IncidencesController < ApplicationController
  layout "admin/admin_layout"

  before_action :set_incidence, only: [:show]
  load_and_authorize_resource

  def index
    @incidences = Incidence.all
  end

  def show
    @incidences = Incidence.find(params[:id])
    @incidence_tracking_status = IncidenceTracking.where(:incidence_id => params[:id]).select(:status, :date).order(:date).first
    @incidence_tracking_incidence = IncidenceTracking.where(:incidence_id => params[:id]).select(:id, :staff_id, :status, :message, :date)
  end

  private
  def set_incidence
    @incidence = Incidence.find(params[:id])
  end
end
