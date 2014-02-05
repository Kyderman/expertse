class ExpertsController < ApplicationController
  require 'nokogiri'
  require 'open-uri'
  before_action :set_expert, only: [:show, :edit, :update, :destroy]
  
  # GET /experts
  def index
    @experts = Expert.all.paginate(:page => params[:page], :per_page => 10)
    if($current_expert)
      @search_text = 'Search via tags...'
      @dis = false
    else
      @search_text = 'Must make an expert active before searching'
      @dis = true
    end
  end
  
  # set current expert
  def set_current_expert
    $current_expert = Expert.find(params[:id])
    redirect_to :back
  end
  
  # remove current expert
  def remove_current_expert
    $current_expert = nil
    redirect_to :back
  end

  # GET /experts/1
  def show
    @tags = @expert.tags.paginate(:page => params[:tag_page], :per_page => 5)
    @friends = @expert.friends.paginate(:page => params[:friend_page], :per_page => 5)
    
    if($current_expert == @expert)
        @search_text = 'Search via tags...'
        @dis = false
    else
        @search_text = 'Must make this expert active, before searching'
        @dis = true
    end
  end

  # GET /experts/new
  def new
    @expert = Expert.new
  end

  # GET /experts/1/edit
  def edit
    
  end

  # POST /experts
  def create
    @expert = Expert.new(expert_params)

    respond_to do |format|
      if @expert.web_check(@expert.long_website)
        format.html { redirect_to @expert, notice: 'Expert was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /experts/1
  def update
    respond_to do |format|
      if @expert.web_check(expert_params[:long_website]) && @expert.update(expert_params)
        format.html { redirect_to @expert, notice: 'Expert was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /experts/1
  def destroy
    if ($current_expert == @expert)
      $current_expert = nil
    end
    @expert.destroy
    
    respond_to do |format|
      format.html { redirect_to experts_url }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expert
      @expert = Expert.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expert_params
      params.require(:expert).permit(:firstname, :surname, :long_website)
    end
end
