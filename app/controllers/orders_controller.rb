class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :redirect_if_invalid_order, only: [:index, :create]

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      return redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_SECRET_KEY"]
      render 'index', status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :street, :building, :phone).merge(item_id: params[:item_id], user_id: current_user.id, token: params[:token])
  end

  def pay_item
    return if Rails.env.test?

    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: order_params[:price], # 商品の値段
      card: order_params[:token],   # カードトークン
      currency: 'jpy'               # 通貨の種類（日本円）
    )
  end
  
  def set_item
    @item = Item.find(params[:item_id])
  end
  
  def redirect_if_invalid_order
    if @item.order.present? || @item.user_id == current_user.id
      redirect_to root_path and return
    end
  end
end
