class AddressesController < ApplicationController

before_action :set_address
before_action :correct_user
before_action :admin_only,       only: [:index]
skip_before_action :set_address, only: [:index]

def index
end

def show
end

def destroy
	@address.delete
end

private
  def set_address
  	@address = Address.find(params[:id])
  end

  def correct_user
      unless @address.location_type == "Store"
      	@user = User.find(@address.location_id)
        redirect_to(root_url) unless current_user?(@user) || you_da_boss?
      end
  end