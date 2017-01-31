class ItemsController < ApplicationController

  before_action :admin_only, only: [:index, :new, :edit, :create, :update, :destroy]

  def index
    @items = Item.paginate(page: params[:page])
  end

  def new
    @item = Item.new
    @item.store_id = params[:id]
  end

  def edit
    @item = Item.find(params[:id])
  end

  def show
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(item_params)
    @item.store_id = params[:id]
    if @item.save
      flash[:success] = "Item Added!"
      redirect_to @item
    else
      render 'new'
    end
  end

  def update
  end

  def destroy
  end

    private

    def item_params
      params.require(:item).permit(:name, :price, :image)
    end

    def admin_only
      unless logged_in? && you_da_boss?
        flash[:danger] = "That's my purse I don't know you!"
        redirect_to root_url
      end
    end
end
