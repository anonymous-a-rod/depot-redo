class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart
  
  def index
    @products = Product.order(:title)

    @count = session[:counter] = 0 if session[:counter].nil?
    @count = session[:counter] += 1
  end
end
