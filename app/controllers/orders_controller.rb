class OrdersController < ApplicationController

  before_action :set_item, only: [:index, :create]

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_address).permit(:postal_code,:prefecture_id,:city,:address_line,:building,:phone,:token).merge(user_id: current_user.id, item_id: params[:item_id])
  end

   def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: (@item.price * 1.1).floor,
      card: order_params[:token],
      currency: 'jpy'
    ) 
   end
end
