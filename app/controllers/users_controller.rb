class UsersController < ApplicationController
  require 'will_paginate/array'

  skip_before_filter :find_current_user, :only => [:new, :create]
  before_filter :user_present?, :only => [:new]
  before_filter :find_user, :only => [:following, :followers, :show]

  def following
    @title = "Following"
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end
  
  def followers
    @title = "Follower"
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def show
    @micropost = current_user.microposts.build
    debugger
    @feed_items = @user.feed.paginate(page: params[:page])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.find_or_create_by_name(params[:user])
    if @user
      session[:user_id] = @user
      flash[:success] = "Welcome to the Vinsol App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def index
    @users = User.paginate(page: params[:page])
  end

  private

  def user_present?
    current_user = User.find_by_id(session[:user_id])
    if current_user.present?
      redirect_to current_user
    end
  end

  def find_user
    @user = User.find(params[:id])
  end

end
