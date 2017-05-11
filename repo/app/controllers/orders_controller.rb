class OrdersController < ApplicationController

#callbacks
before_action :logged_in_user
before_action :set_order      
before_action :set_runner
before_action :set_customer,    only: [:show]       
before_action :correct_user,    only: [:show]
before_action :correct_runner,  only: [:progress, :finished]
before_action :admin_only,      only: [:index, :edit, :update]

skip_before_action :set_order,  only: [:create, :index, :assigned]
skip_before_action :set_runner, only: [:create, :index, :assigned]

#RESTful actions
#visibile
  def index
    @orders = Order.all
  end

  def edit
  end

  def show
    @order ||= current_user.account.orders.last
  end

  def assigned
    @orders = Order.all.where(runner_id: current_user.runner.id)
  end

#invisible
  def create
    @cart = current_user.account.orders.new
    if @cart.save
      redirect_to @cart
    else
      flash[:warning] = "Cart could not be created"
      redirect_to root_url
    end
  end
    

  def update
    if @order.update_attributes(assignment_params)
      flash[:success] = "Order updated"
      redirect_to @order
    else
      render 'edit'
    end
  end
    
  def progress
    if @order.update_attributes(progress_params)
      unless @order.retail_total.nil? || @order.receipt.nil?
        @order.progress!
        @order.send_progress_email
        redirect_to @order
      end
    else
      render 'show'
    end
  end

  def finished
    @order.finished!
    @order.send_finished_email
    redirect_to @order
  end

  private

    #mass assignment filters

    def assignment_params
      params.require(:order).permit(:runner_id)
    end

    def progress_params
      params.require(:order).permit(:receipt, :retail_total)
    end

    ##callbacks
    #setters
    def set_order
      if params[:id]
        @order = Order.find(params[:id])
      else
        @order = @cart
        if @order.nil? || @order.status == 'done'
          create
        end
      end
    end

    def set_customer
      @cust = Customer.find(@order.customer_id).user
    end

    def set_runner
      @runn = Runner.find(@order.runner_id).user
    end

    #checkers    
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
    end

    def correct_user
      unless current_user?(@cust) || current_user?(@runn) || you_da_boss? || you_dispatch?
        redirect_to(root_url) 
      else
        return true
      end
    end

    def correct_runner
      redirect_to(root_url) unless current_user?(@runn)
    end

    def admin_only
      unless you_da_boss? || you_dispatch?
        flash[:danger] = "That's my purse I don't know you!"
        redirect_to root_url
      end
    end

end
