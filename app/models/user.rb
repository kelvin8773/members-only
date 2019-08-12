class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  
  attr_accessor :remember_token

  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, 
                    length: { maximum: 100 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }

  has_secure_password

  validates :password, presence: true, length: { minimum: 6 }


  def digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost

    BCrypt::Password.create(string, cost: cost)
  end

  def new_token
    SecureRandom.urlsafe_base64 
  end

  def create_remember_token
    self.remember_token = self.new_token
    update_attribute(:remember_digest, self.digest(self.remember_token))
  end
  
  def remove_remember_token
    update_attribute(:remember_digest, nil)
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(self.remember_digest).is_password?(remember_token)
  end


end
