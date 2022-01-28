class User < ActiveRecord::Base
  has_secure_password

  def self.authenticate_with_credentials(e, p)
    # self.find_by_email_and_password_digest([e], [p])
    self.find_by(email: [e]).try(:authenticate, [p]) 
  end

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false}
  validates :password_confirmation, presence: true, length: 2..20

  

end
