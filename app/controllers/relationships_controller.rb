class RelationshipsController < ApplicationController

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    respond_to do |format|
      format.html {redirect_to @user}
      format.js do
        render :partial => 'users/unfollow'
      end
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_to do |format|
      format.html {redirect_to @user}
      format.js { render :partial => 'users/follow' }
    end
  end

 def total_followers
   render :json => {:followers => current_user.followed_users.count }
 end

end
