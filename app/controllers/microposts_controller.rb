class MicropostsController < ApplicationController

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_path
    else
      @user = current_user
      @feed_items = @user.feed.paginate(page: params[:page])
      render 'users/show'
    end
  end

  def retweet
   @post = Micropost.find(params[:id])
   current_user.microposts.create(:content => @post.content, :retweet => true)
   @micropost = current_user.microposts.build
   @user = current_user
   @feed_items = @user.feed.paginate(page: params[:page])
   render 'users/show'
  end
  
end
