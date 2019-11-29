class IncidencesController < ApplicationController
  before_action :set_incidence, only: [:show]

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
