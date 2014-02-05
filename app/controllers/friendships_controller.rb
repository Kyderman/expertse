class FriendshipsController < ApplicationController
  before_action :set_friendship, only: [:destroy]

  # GET /friendships
  def index
    @friendships = Friendship.all.paginate(:page => params[:page], :per_page => 10)
  end

  
  # GET /friendships/new
  def new
    @friendship = Friendship.new
  end

  # POST /friendships
  def create
    @friendship = Friendship.new(friendship_params)
    
    respond_to do |format|
      if Friendship.request(@friendship.expert, @friendship.friend)
        format.html { redirect_to :back, notice: 'Friendship was successfully created.' }
      else
        format.html { redirect_to :back, :flash => { :warning => 'Friendship was not created - Expert and friend must be different'} }
      end
    end
  end


  # DELETE /friendships/1@f@f
  def destroy
    @cur_ex = Expert.find(@friendship.expert_id)
    @newf = @cur_ex.inverse_friendships.where(expert_id: @friendship.friend_id, friend_id: @friendship.expert_id).first
    
    @friendship.destroy
    @newf.destroy
    
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Friendship successfully removed.' }
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
