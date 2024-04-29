class User < ApplicationRecord

    has_secure_password
    
    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password, presence: true, length: { minimum: 6 }

    ROLES = ['admin', 'user'].freeze

    validates :role, inclusion: { in: ROLES }
    def admin?
        role == 'admin'
    end

end
