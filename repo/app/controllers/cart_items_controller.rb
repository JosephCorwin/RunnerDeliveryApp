class CartItemsController < ApplicationController

before_action :set_cart_item
before_action :ordered?

skip_before_action :set_cart_item, only: [:create]

  def create
  	@order = @cart
  	if @order.status == 'cart'
  		if existing_cart_item = @order.cart_items.select{ |c| c.item_id == params[:cart_item][:item_id] }.first
  	      existing_cart_item.quantity += create_params[:quantity]
  	      existing_cart_item.save
  	    else
  	      @order.cart_items.create!(create_params)
  	    end
  	end
  end

  def update
  	@cart_item.update_attributes(update_params)
  	redirect_to @cart
  end

  def destroy
  	@cart_item.destroy
  	redirect_to @cart
  end

  def increase
  	@cart_item.quantity += 1
  	@cart_item.save
  	redirect_to @cart
  end

  def reduce
  	@cart_item.quantity -= 1
  	@cart_item.save
  	redirect_to @cart
  end



  private

    def create_params
      params.require(:cart_item).permit(:item_id, :quantity)
    end

    def update_params
      params.require(:cart_item).permit(:quantity)
    end

    def set_cart_item
      @cart_item = CartItem.find(params[:id])
    end

    def ordered?
      if @cart_item.order.ordered?
      	redirect_to @cart
      end
    end

    def correct_user?
      user = @cart_item.order.account.user
      unless user == current_user
      	redirect_to root_url
      end
    end
end
