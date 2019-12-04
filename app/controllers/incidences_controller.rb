class IncidencesController < ApplicationController
  layout "admin/admin_layout"

  before_action :set_incidence, only: [:show]
  load_and_authorize_resource

  def index
    @incidences = Incidence.all
  end

  def show
  end

  private
  def set_incidence
    @incidence = Incidence.find(params[:id])
  end
end
