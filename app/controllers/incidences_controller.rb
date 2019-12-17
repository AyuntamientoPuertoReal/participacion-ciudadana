class IncidencesController < ApplicationController
  layout "admin/admin_layout"

  before_action :set_incidence, only: [:show]
  load_and_authorize_resource

  def index
    @incidence_type_name = Hash.new
    incidence_type = IncidenceType.all

    incidence_type.each do |incidence_type|
      @incidence_type_name[incidence_type.id] = incidence_type.name
    end

    @incidences = Incidence.all

  end

  def show
    @staff_names = {0 => "Ciudadano"}

    @incidence_tracking_status = IncidenceTracking.where(:incidence_id => params[:id]).select(:status, :created_at).order("created_at DESC").first
    incidence_tracking_incidence = IncidenceTracking.where(:incidence_id => params[:id]).select(:id, :staff_id, :status, :message, :created_at).order(:created_at)
    incidence_tracking_enviado = IncidenceTracking.new({:id => 0, :staff_id => 0, :status => 1, :message => "Creacion de la Incidencia", :created_at => @incidence.created_at})
    
    if incidence_tracking_incidence.empty?
      @incidence_tracking_incidence = Array(incidence_tracking_enviado)
    else
      @incidence_tracking_incidence = Array(incidence_tracking_enviado) + Array(incidence_tracking_incidence)

      incidence_tracking_incidence.each do |tracking|
        @staff_names[tracking.staff_id] = Staff.find(tracking.staff_id).full_name
      end
    end 

  end

  private
  def set_incidence
    @incidence = Incidence.find(params[:id])
  end
end
