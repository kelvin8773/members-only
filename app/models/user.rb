class User < ApplicationRecord
  attr_accessor :remember_token

  # before_create  :create_remember_token

  has_secure_password

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

end
