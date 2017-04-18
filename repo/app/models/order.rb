class Order < ApplicationRecord

  #relations, far and wide
  belongs_to :customer
  belongs_to :runner
  has_many :cart_items

  #receipts!
  mount_uploader :receipt, ReceiptUploader

  #callbacks
  before_create { self.runner_id ||= 1 }
  before_create { self.status ||= 'cart' }

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
    if self.where_it_goes.nil?
      errors.add(:order, "Needs a delivery location")
    elsif self.what_they_want.nil? || self.cart_items.nil? #leaving what_they_want for vesitgial first-round orders before stores get filled out
      errors.add(:order, "Need something to deliver")
    else
      self.status == 'open'
      save
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
    if self.status == 'open'
      self.status = 'prog'
      self.time_obtained = Time.zone.now
      save
    end
  end

  def finished?
    return false unless self.status == 'done'
  end

  def finished!
    self.status = 'done'
    self.time_delivered = Time.zone.now 
    save
  end

end
