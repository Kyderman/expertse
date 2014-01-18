class FriendshipsController < ApplicationController
  before_action :set_friendship, only: [:show, :edit, :update, :destroy]

  # GET /friendships
  # GET /friendships.json
  def index
    @friendships = Friendship.all
  end

  # GET /friendships/1
  # GET /friendships/1.json
  def show
  end

  # GET /friendships/new
  def new
    @friendship = Friendship.new
  end

  # GET /friendships/1/edit
  def edit
  end

  # POST /friendships
  # POST /friendships.json
  def create
    @friendship = Friendship.new(friendship_params)
    
    
      
    

    respond_to do |format|
      if 
        format.html { redirect_to :back, notice: 'Friendship was successfully created.' }
        format.json { render action: 'index', status: :show, location: :back }
        
        
      else
        format.html { redirect_to :back, :flash => { :warning => 'Friendship was not created - Expert and friend must be different'} }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /friendships/1
  # PATCH/PUT /friendships/1.json
  def update
    respond_to do |format|
      if @friendship.update(friendship_params)
        format.html { redirect_to @friendship, notice: 'Friendship was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friendships/1@f@f
  # DELETE /friendships/1.json
  def destroy
    
      @cur_ex = Expert.find(@friendship.expert_id)
       @newf = @cur_ex.inverse_friendships.where(expert_id: @friendship.friend_id, friend_id: @friendship.expert_id).first
    
    
    @friendship.destroy
    @newf.destroy
    
    respond_to do |format|
     
        format.html { redirect_to :back, notice: 'Friendship successfully removed.' }
      
     
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friendship
      @friendship = Friendship.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def friendship_params
      params.require(:friendship).permit(:expert_id, :friend_id)
    end
end
