class OrdersController < ApplicationController

  def show
    DEBUG_LOG.info params
    @order = Order.find_by(id: params[:id])
    return redirect_to '/' unless @order
  end

  def new
    @order = Order.new
  end

  def create
    DEBUG_LOG.info params
  end

  def index
    @orders = Order.all
  end
end
