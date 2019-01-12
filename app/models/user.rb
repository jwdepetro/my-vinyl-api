class User < ApplicationRecord
    # Hash passwords
    has_secure_password

    # A User has many Records
    has_many :records, foreign_key: :created_by
    
    # Required fields
    validates_presence_of :name, :email, :password_digest
end
