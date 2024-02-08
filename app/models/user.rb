class User < ApplicationRecord
    self.table_name = 'users'
    has_secure_password

    validates_presence_of :first_name, :last_name, :email, :password, message: "First Name, Last Name, Email and Password are required fields"
end
