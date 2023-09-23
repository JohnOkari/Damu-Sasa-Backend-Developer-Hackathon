class User < ApplicationRecord
    enum role: { user: 'user', admin: 'admin' }, _default: 'user'

    validates :email, presence: true, uniqueness: true
    validates :role, presence: true, inclusion: { in: %w(user admin) }

    has_secure_password
    has_many :appointments
    has_many :prescriptions
  
    def admin?
      role == 'admin'
    end
end
  