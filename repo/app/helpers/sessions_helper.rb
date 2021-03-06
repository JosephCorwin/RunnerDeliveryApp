module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  #Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  #set the user
  def current_user
    if (user_id = session[:user_id]) #user is logged_in
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id]) #user has remember cookie
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    else
      @current_user = false
    end
  end

  #set the cart
  def current_cart
    if current_user && logged_in?
      @cart = current_user.account.orders.last 
    end
  end

  #check the cart
  def cart_status
    if @cart.present?
      if @cart.status == 'cart'
        if @cart.subtotal > 0
          @cart.tax
          return "Cart (#{number_to_currency(@cart.total, precision: 2)})"
        else
          return "Cart"
        end  
      elsif @cart.status == 'done'
        return "New Order"
      else
        return "Track Order"
      end
    else
      return "Cart"
    end
  end
        

  #check the user
  def current_user?(user)
    user == current_user
  end

  #check the user is there
  def logged_in?
    unless session[:user_id].nil?
      return current_user
    end
  end

  def require_login
    unless logged_in?
      store_location
      flash[:danger] = "Please log in"
      redirect_to login_url
    end
  end

  #restricted access
  def admin_only
      unless current_user && you_da_boss?
        flash[:danger] = "That's my purse I don't know you!"
        redirect_to root_url
      end
    end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end    

  #friendly forwarding!
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  #Permission slips
  def you_da_boss?
    @current_user.is_boss? if @current_user
  end

  def you_dispatch?
    @current_user.is_dispatcher? if @current_user
  end

  def you_running?
    @current_user.is_runner? if @current_user
  end

end
