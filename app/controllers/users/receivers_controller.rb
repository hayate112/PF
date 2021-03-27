class Users::ReceiversController < ApplicationController
  before_action :authenticate_user!

  def index
    @receiver = Receiver.new
    @receivers = current_user.receivers
  end

  def create
    @receiver = Receiver.new(receiver_params)
    @receivers = current_user.receivers
    if @receiver.save
      redirect_to receivers_path
    else
      flash[:notice] = "必要な項目が未入力です"
      render :index
    end
  end

  def edit
    @receiver = Receiver.find(params[:id])
  end

  def update
    @receiver = Receiver.find(params[:id])
    if @receiver.update(receiver_params)
      redirect_to receivers_path
    else
      flash[:notice] = "必要な項目が未入力です"
      render :edit
    end
  end

  def destroy
    receiver = Receiver.find(params[:id])
    receiver.destroy
    redirect_to receivers_path
  end

  private

  def receiver_params
    params.require(:receiver).permit(:user_id, :postal_code, :prefectures, :city, :name)
  end
end
