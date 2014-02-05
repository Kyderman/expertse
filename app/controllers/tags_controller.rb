class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]

  # GET /tags
  # GET /tags.json
  def index
    #Simpleforms doesnt like playing with searching...
    
    if(params[:search])
      @term = params[:search].first[1]
      @tags = Tag.search(@term)
      @search = true
    else
      @tags = Tag.all
      @search = false
    end
    @tags = @tags.paginate(:page => params[:page], :per_page => 10)
  end

  

  # GET /tags/new
  def new
    @tag = Tag.new
  end

  

  # POST /tags
  # POST /tags.json
  def create
    @tag = Tag.new(tag_params)

    respond_to do |format|
      if @tag.save
        format.html { redirect_to @tag, notice: 'Tag was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tag }
      else
        format.html { render action: 'new' }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

 

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    @tag.destroy
    respond_to do |format|
      format.html { redirect_to tags_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_params
      params.require(:tag).permit(:expert_id, :tag)
    end
end
