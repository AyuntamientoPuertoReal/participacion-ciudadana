class IncidencesController < ApplicationController
  layout "admin/admin_layout"

  before_action :set_incidence, only: [:show]
  load_and_authorize_resource

  def index
    user_role = current_user.role.id

    if user_role == 1
      @incidence = Incidence.all
    else
      user_id = current_user.id

      proc_un_user = PuStaff.where(:staff_id => user_id).select(:processing_unit_id).distinct
      incidences_types_pu_staff = PuIt.where(:processing_unit_id => proc_un_user.select(:processing_unit_id)).select(:incidence_type_id).distinct
      @incidences = Incidence.where(:incidence_type_id => incidences_types_pu_staff.select(:incidence_type_id)).distinct
    end
    
    #SELECT inc1.id, inc1.incidence_id, inc1.status
    #FROM incidence_trackings inc1
    #INNER JOIN(SELECT incidence_id as incidence_trackings_incidence_id, Max(created_at) as maximum_created_at FROM "incidence_trackings" GROUP BY "incidence_trackings"."incidence_id") inc_trac_group
    #ON inc1.incidence_id = inc_trac_group.incidence_id
    #AND inc1.created_at = inc_trac_group.created_at

    #incidence_tracking_group = IncidenceTracking.group(:incidence_id).select("incidence_id as incidence_trackings_incidence_id, Max(created_at) as maximum_created_at")
    incidence_tracking_status = ActiveRecord::Base.connection.execute(
      "SELECT inc1.id, inc1.incidence_id, inc1.status
       FROM incidence_trackings inc1
       INNER JOIN(SELECT incidence_id as incidence_trackings_incidence_id, Max(created_at) as maximum_created_at FROM incidence_trackings GROUP BY incidence_id) inc_trac_group
      ON inc1.incidence_id = inc_trac_group.incidence_trackings_incidence_id
    AND inc1.created_at = inc_trac_group.maximum_created_at"
    )
    #IncidenceTracking.joins(incidence_tracking_group).where("inc1.incidence_id = inc_trac_group.incidence_id AND inc1.created_at = inc_trac_group.created_at")

    puts incidence_tracking_status

    @incidence_type_name = Hash.new
    incidence_type = IncidenceType.where(:id => @incidences.select(:incidence_type_id)).select(:id, :name)

    incidence_type.each do |incidence_type|
      @incidence_type_name[incidence_type.id] = incidence_type.name
    end

    @incidences = @incidences.order(:created_at).reverse_order

  end

  def show
    @staff_names = {0 => "Ciudadano"}
    @user_role = current_user.role.id

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
