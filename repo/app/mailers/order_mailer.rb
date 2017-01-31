class OrderMailer < ApplicationMailer

  def order_created(order)
    @user  = order.customer.user
    @order = order
    mail to: @user.email, subject: "Order has been placed!"
  end

  def order_assigned(order)
    @user  = order.customer.user
    @order = order
    mail to: @user.email, subject: "A runner has been selected!"
  end

  def order_progressed(order)
    @user  = order.customer.user
    @order = order
    mail to: @user.email, subject: "#{order.runner.user.first_name} has picked up your order"
    #mail to: 'dispatch@runnerdeliveries.com', subject: "#{order.runner.user.first_name} has picked up items for order #{order.id}"
  end

  def order_finished(order)
    @user  = order.customer.user
    @order = order
    mail to: @user.email, subject: "Thank you!"
    #mail to: 'dispatch@runnerdeliveries.com', subject: "Order #{order.id} is complete!"
  end

end

