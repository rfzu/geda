class OrdersController < ApplicationController

  def show
  end

  def index
    @orders = Order.all
  end
end
