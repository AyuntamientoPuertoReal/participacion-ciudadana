class NewsController < ApplicationController
  layout "admin/admin_layout"

  before_action :set_news, only: [:show, :edit, :update, :destroy]
  before_action :set_edit, only: [:new, :edit]

  # GET /news
  # GET /news.json
  def index
    @current_user = current_user
    @news = News.all
    @user_role = current_user.role.id
    @user_publish = current_user.can_publish
    @author_name = Hash.new

    @news.each do |new_author|
      @author_name[new_author.author_id] = Staff.find(new_author.author_id).full_name
    end 
  end

  # GET /news/1
  # GET /news/1.json
  def show
    @author_name = Staff.find(@news.author_id).full_name
  end

  # GET /news/new
  def new
    @edit = false
    @news = News.new
    @user_publish = current_user.can_publish
    @author_name = current_user.full_name
  end

  # GET /news/1/edit
  def edit
    @author_name = Staff.find(@news.author_id).full_name
    @user_publish = current_user.can_publish
  end

  # POST /news
  # POST /news.json
  def create
    @news = News.new(news_params)
    @news.author_id = current_user.id

    if @news.published.nil? 
      @news.published = false
    end
    
    respond_to do |format|
      if @news.save
        format.html { redirect_to @news, notice: 'News was successfully created.' }
        format.json { render :show, status: :created, location: @news }
      else
        format.html { render :new }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /news/1
  # PATCH/PUT /news/1.json
  def update
    @news.last_editor_id = current_user.id
    
    if @news.published.nil? 
      @news.published = false
    end

    respond_to do |format|
      if @news.update(news_params)
        format.html { redirect_to @news, notice: 'News was successfully updated.' }
        format.json { render :show, status: :ok, location: @news }
      else
        format.html { render :edit }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news/1
  # DELETE /news/1.json
  def destroy
    @news.destroy
    respond_to do |format|
      format.html { redirect_to news_index_url, notice: 'News was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news
      @news = News.where(:slug => params[:id]).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def news_params
      params.fetch(:news, {})
    end

    def set_edit
      @edit = true
    end
end
