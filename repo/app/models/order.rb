class Order < ApplicationRecord

  #relations, far and wide
  belongs_to :customer
  belongs_to :runner
  has_many :cart_items

  #receipts!
  mount_uploader :receipt, ReceiptUploader

  #callbacks
  before_create :assign_order_to_optimus
  before_create :set_order_as_cart

  #validation parameters
  validates :what_they_want, presence: true
  validates :where_it_goes,  presence: true

  #email senders
  def send_creation_email
    OrderMailer.order_created(self).deliver_now
  end

  def send_assignment_email
    OrderMailer.order_assigned(self).deliver_now
  end

  def send_progress_email
    OrderMailer.order_progressed(self).deliver_now
  end

  def send_finished_email
    OrderMailer.order_finished(self).deliver_now
  end

  #status control
  def ordered?
    return false if self.status == 'cart'
  end

  def order!
    if self.status == 'cart'
      if self.where_it_goes.nil?
        errors.add(:order, "needs a delivery location")
      elsif self.what_they_want.nil? || self.cart_items.nil? #leaving what_they_want for vesitgial first-round orders before stores get filled out
        errors.add(:order, "needs something to deliver")
      else
        self.status = 'open'
        save
      end
    else
      errors.add(:order, 'is already ordered')
    end
  end

  def assigned?
    return true unless self.runner.id == 1
  end

  def assign!(runner_id)
    self.runner_id = runner_id
    save
  end

  def progressed?
    self.status == 'prog' || self.status == 'done'
  end

  def progress!
    unless self.receipt.nil?
      self.status = 'prog'
      self.time_obtained = Time.zone.now
      save
    else
      errors.add(:order, 'needs a receipt')
    end
  end

  def finished?
    return false unless self.status == 'done'
  end

  def finished!
    if self.status == 'prog'
      self.status = 'done'
      self.time_delivered = Time.zone.now 
      save
    else
      errors.add('How did you even get a button to request this?')
    end
  end

  private
  
    def assign_order_to_optimus
      self.runner_id = 1
    end

    def set_order_to_cart
      self.status = 'cart'
    end

  end

end
