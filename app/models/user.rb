class User < ApplicationRecord
    has_secure_password
    validates_presence_of :first_name, :last_name, :email, :password, message: "First Name, Last Name, Email and Password are required fields"
    validates_uniqueness_of :email
end
