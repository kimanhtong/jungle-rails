class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false}
  validates :password_confirmation, presence: true, length: 2..20
  
  def self.authenticate_with_credentials(e, p)
    user = User.where('lower(email) = ?', e.strip.downcase).first
    if user && user.authenticate(p)
      return user
    end
  end
end

