class User < ApplicationRecord

  #relations, far and wide
  has_one :runner,     dependent: :destroy
  has_one :account,    dependent: :destroy, class_name: 'Customer'
  has_one :dispatcher, dependent: :destroy
  has_many :addresses, dependent: :destroy, as: :location

  #tokens, bruh
  attr_accessor :remember_token, :activation_token, :reset_token

  #facetime!
  mount_uploader :image, ImageUploader

  #regex formatting parameters
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  CLEAN_PHONE_REGEX = /[.!@$%^&*()a-zA-z\s$]/

  #callbacks
  before_validation { self.status ||= "news" }
  before_save { self.email.downcase! }
  before_save { if self.phone && self.phone.match(CLEAN_PHONE_REGEX) then self.phone.gsub(CLEAN_PHONE_REGEX, '') end }
  before_create :create_activation_digest
  after_create { self.add_customer_account }

  #validation parameters
  validates :first_name, presence: true, length: { maximum: 64 }
  validates :last_name, presence: true, length: { maximum: 64 }
  validates :email, presence: true,  length: { maximum: 65 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :phone, presence: true, length: { maximum: 15 }
  validates :status, presence: true, length: { maximum: 4 }
  validates_processing_of :image
  validate :image_size_validation
  has_secure_password #because duuuh
  #validates :password, presence: true, length: { minimum: 8 }

  #account (de)activation methods
  def activate!
    update_columns(activated: true, activated_at: Time.zone.now, status: 'good')
  end

  def deactivate!
    self.activated = false
    save 
  end

  def activated?
    return true if self.activated == true
  end

  def deactivated?
    return true if self.activated == false && self.activated_at
  end

  #email senders
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end
  
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  #low-budget encryption parameters
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # 'member? I 'member!
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget #i don't wanna 'member no more!
    update_attribute(:remember_digest, nil)
  end

  def set_primary_address(address)
    if address.location_id == self.id 
      self.primary_address = address.id
      save
    end
  end

  def get_primary_address
    if self.primary_address
      Address.find(self.primary_address).address
    else
      return false
    end 
  end


  #check digests
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  #password resets
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  #status control
  def is_boss?
    return true if self.status == 'boss'
  end

  def is_boss!
    return false
  end
  
  def is_good?
    return true if self.status == 'good'
  end

  def is_good!
    self.status = 'good'
    save
  end

  def is_problem?
    return true if self.status == 'prob'
  end

  def is_problem!
    self.status = 'prob'
    save
  end

  def is_runner?
    return true if self.status == 'runn'
  end

  def is_runner!
    self.status = 'runn'
    save
    self.create_runner! unless self.runner
  end

  def is_dispatcher?
    return true if self.status == 'disp'
  end
 
  def is_dispatcher!
    self.status = 'disp'
    save
    self.create_dispatcher! unless self.dispatcher
  end
 
  def works_here?
    return true if self.is_runner? or self.is_dispatcher? or self.is_boss?
  end

  def is_fired!
    self.status = 'good'
    save
  end

  def is_fired?
    if self.runner
      return true unless self.is_runner?
    elsif self.dispatcher
      return true unless self.is_dispatcher?
    else
      return false
    end
  end

  #extra getters
  def full_name
    self.first_name + ' ' + self.last_name
  end

  #add customers with confidence
  def add_customer_account
    self.create_account! unless self.account
  end

  private
    
    #prime the activation system
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
    

    def image_size_validation
      errors[:image] << "should be less than 500KB" if image.size > 0.5.megabytes
    end

    def image_changed?
       return false
    end
end
