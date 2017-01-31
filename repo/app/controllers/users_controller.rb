class UsersController < ApplicationController

before_action :set_user
before_action :logged_in_user
before_action :correct_user
before_action :admin_only

skip_before_action :set_user,       only: [:new, :create, :index]
skip_before_action :logged_in_user, only: [:new, :create]
skip_before_action :correct_user,   only: [:new, :create, :edit ,:index]
skip_before_action :admin_only,     only: [:new, :create, :edit]


  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def show
    redirect_to root_url and return unless @user.activated?
  end

  def create
    @user = User.new(new_user_params)
    if @user.save
       @user.send_activation_email
       render 'check_email'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
      byebug
      if @user.update_attributes(edit_user_params)
        flash[:success] = "Account info updated!"
        redirect_to @user
      else
        render 'edit'
      end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def check_email
  end

  def hire
    @user.is_runner! unless @user.is_fired?
    redirect_to @user
  end

  def fire
    @user.is_fired!
    redirect_to @user
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def new_user_params
      params.require(:user).permit(:first_name,
                                   :last_name, 
                                   :email, 
                                   :phone,
                                   :password, 
                                   :password_confirmation )
    end

    def edit_user_params
      params.require(:user).permit(:first_name,
                                   :last_name, 
                                   :email, 
                                   :phone, 
                                   :image,
                                   :remove_image )
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user) || you_da_boss?
    end

    def admin_only
      unless logged_in? && you_da_boss?
        flash[:danger] = "That's my purse I don't know you!"
        redirect_to root_url
      end
    end

end
