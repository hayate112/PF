class Users::UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def unsubscribe
  end

  def withdraw
    current_user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会しました"
    redirect_to root_path
  end
end
