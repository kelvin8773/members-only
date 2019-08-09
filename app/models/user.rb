class User < ApplicationRecord
  attr_accessor :remember_token

  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, 
                    length: { maximum: 100 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }

  has_secure_password

  validates :password, presence: true, length: { minimum: 6 }


  def digest(string)
    Digest::SHA1.hexdigest(string)
  end

  def new_token
    SecureRandom.urlsafe_base64 
  end

  def create_remember_token
    self.remember_token = self.new_token
    update_attribute(:remember_digest, self.digest(self.remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    remember_digest == User.digest(remember_token)
  end

end
