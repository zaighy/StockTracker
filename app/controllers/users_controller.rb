class UsersController < ApplicationController

  def portfolio
    @user = current_user
    @user_stocks = current_user.stocks
  end

  def friends
    @friendships = current_user.friends
  end

  def search
    if StocksHelper::empty_string params[:search_param]
      flash.now[:danger] = "Entered empty search string"
    else
      @users = User.search(params[:search_param])
      @users = current_user.except_current_user(@users)
      flash.now[:danger] = "No users match this search" if @users.blank?
    end

    respond_to do | format|
      format.js { render partial: 'friends/result' }
    end
  end

  def add_friend
    @friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: @friend.id)
    if current_user.save
      flash[:success] = "Friend was successfully added"
    else
      flash[:danger] = "Something went wrong with friend reqeust"
    end
    redirect_to friends_path
  end

end
