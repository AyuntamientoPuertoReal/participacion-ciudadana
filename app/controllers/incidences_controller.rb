class IncidencesController < ApplicationController
  layout "admin/admin_layout"

  skip_authorize_resource only: [:index_new, :index_inprocess, :index_closed]

  before_action :set_incidence, only: [:show]
  load_and_authorize_resource

  def index_new
    user_role = current_user.role.id
    incidence_tracking_where_status = IncidenceTracking.all.select(:incidence_id)

    user_id = current_user.id

    proc_un_user = PuStaff.where(:staff_id => user_id).select(:processing_unit_id).distinct
    incidences_types_pu_staff = PuIt.where(:processing_unit_id => proc_un_user.select(:processing_unit_id)).select(:incidence_type_id).distinct
    @incidences = Incidence.where(:incidence_type_id => incidences_types_pu_staff.select(:incidence_type_id)).where.not(:id => incidence_tracking_where_status.select(:incidence_id)).distinct
    
    #SELECT inc1.id, inc1.incidence_id, inc1.status
    #FROM incidence_trackings inc1
    #INNER JOIN(incidence_tracking_group) inc_trac_group
    #ON inc1.incidence_id = inc_trac_group.incidence_id
    #AND inc1.created_at = inc_trac_group.created_at

    @incidence_tracking_status = IncidenceTracking.joins('INNER JOIN (SELECT incidence_id, MAX(created_at) as maximum_created_at FROM incidence_trackings GROUP BY incidence_id) "inc_trac_group" ON "incidence_trackings"."incidence_id" = "inc_trac_group"."incidence_id" AND "incidence_trackings"."created_at" = "inc_trac_group"."maximum_created_at"')

    @incidence_type_name = Hash.new
    incidence_type = IncidenceType.where(:id => @incidences.select(:incidence_type_id)).select(:id, :name)

    incidence_type.each do |incidence_type|
      @incidence_type_name[incidence_type.id] = incidence_type.name
    end

    @incidences = @incidences.order(:created_at).reverse_order
  end

  def index_inprocess
    user_role = current_user.role.id

    #SELECT inc1.id, inc1.incidence_id, inc1.status
    #FROM incidence_trackings inc1
    #INNER JOIN(incidence_tracking_group) inc_trac_group
    #ON inc1.incidence_id = inc_trac_group.incidence_id
    #AND inc1.created_at = inc_trac_group.created_at
    @incidence_tracking_status = IncidenceTracking.joins('INNER JOIN (SELECT incidence_id, MAX(created_at) as maximum_created_at FROM incidence_trackings GROUP BY incidence_id) "inc_trac_group" ON "incidence_trackings"."incidence_id" = "inc_trac_group"."incidence_id" AND "incidence_trackings"."created_at" = "inc_trac_group"."maximum_created_at"')
    incidence_tracking_where_status = IncidenceTracking.where(:status => 2).where(:id => @incidence_tracking_status.select(:id)).select(:incidence_id)

    @incidence = Incidence.where(:id => incidence_tracking_where_status.select(:incidence_id))

    user_id = current_user.id

    proc_un_user = PuStaff.where(:staff_id => user_id).select(:processing_unit_id).distinct
    incidences_types_pu_staff = PuIt.where(:processing_unit_id => proc_un_user.select(:processing_unit_id)).select(:incidence_type_id).distinct
    @incidences = Incidence.where(:incidence_type_id => incidences_types_pu_staff.select(:incidence_type_id)).where(:id => incidence_tracking_where_status.select(:incidence_id)).distinct
    
    @incidence_type_name = Hash.new
    incidence_type = IncidenceType.where(:id => @incidences.select(:incidence_type_id)).select(:id, :name)

    incidence_type.each do |incidence_type|
      @incidence_type_name[incidence_type.id] = incidence_type.name
    end

    @incidences = @incidences.order(:created_at).reverse_order
  end

  def index_closed
    user_role = current_user.role.id

    #SELECT inc1.id, inc1.incidence_id, inc1.status
    #FROM incidence_trackings inc1
    #INNER JOIN(incidence_tracking_group) inc_trac_group
    #ON inc1.incidence_id = inc_trac_group.incidence_id
    #AND inc1.created_at = inc_trac_group.created_at
    @incidence_tracking_status = IncidenceTracking.joins('INNER JOIN (SELECT incidence_id, MAX(created_at) as maximum_created_at FROM incidence_trackings GROUP BY incidence_id) "inc_trac_group" ON "incidence_trackings"."incidence_id" = "inc_trac_group"."incidence_id" AND "incidence_trackings"."created_at" = "inc_trac_group"."maximum_created_at"')
    incidence_tracking_where_status = IncidenceTracking.where(:status => [3, 4]).where(:id => @incidence_tracking_status.select(:id)).select(:incidence_id)

    @incidence = Incidence.where(:id => incidence_tracking_where_status.select(:incidence_id))

    user_id = current_user.id

    proc_un_user = PuStaff.where(:staff_id => user_id).select(:processing_unit_id).distinct
    incidences_types_pu_staff = PuIt.where(:processing_unit_id => proc_un_user.select(:processing_unit_id)).select(:incidence_type_id).distinct
    @incidences = Incidence.where(:incidence_type_id => incidences_types_pu_staff.select(:incidence_type_id)).where(:id => incidence_tracking_where_status.select(:incidence_id)).distinct
    
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
  
    puts @incidence_tracking_status
  end

  private
  def set_incidence
    @incidence = Incidence.find(params[:id])
  end
end
