class User < ApplicationRecord
  has_secure_password


  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :status, inclusion: { in: ['active', 'inactive'], message: "%{value} is not a valid status" }

 
  after_initialize :set_defaults, if: :new_record?

  def set_defaults
    self.status ||= 'active'
    self.is_admin ||= false  
  end

  def admin?
    self.is_admin
  end
end
