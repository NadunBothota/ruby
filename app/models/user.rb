class User < ApplicationRecord
  has_secure_password

  # Validations
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :status, inclusion: { in: ['active', 'inactive'], message: "%{value} is not a valid status" }

  # Default values for status and is_admin
  after_initialize :set_defaults, if: :new_record?

  def set_defaults
    self.status ||= 'active' # Default to active
    self.is_admin ||= false   # Default to false for regular users
  end

  # Check if the user is an admin
  def admin?
    self.is_admin
  end
end
