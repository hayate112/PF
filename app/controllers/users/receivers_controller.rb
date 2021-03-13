class Users::ReceiversController < ApplicationController
  def index
    @receiver = Receiver.new
    @receivers = Receiver.all
  end

  def create
    @receiver = Receiver.new(receiver_params)
    @receiver.user_id = current_user.id
    if @receiver.save
      redirect_to receivers_path
    end
  end

  def edit
    @receiver = Receiver.find(params[:id])
  end

  def update
    @receiver = Receiver.find(params[:id])
    if @receiver.update(receiver_params)
      redirect_to receivers_path
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
