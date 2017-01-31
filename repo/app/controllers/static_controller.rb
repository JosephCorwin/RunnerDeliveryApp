class StaticController < ApplicationController
  def home
  end

  def about
  end

  def faq
  end

  def contact
  end

  def contact2
    AnonContactMailer.anon_contact(params[:contact]).deliver_now
    flash[:success] = "Thank you!"
    redirect_to root_url
  end


end
