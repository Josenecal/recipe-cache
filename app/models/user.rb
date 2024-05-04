class User < ApplicationRecord
    has_secure_password
    validates_presence_of :first_name, :last_name, :email, :password
    validates_uniqueness_of :email

    has_many :user_recipes
    has_many :recipes, through: :user_recipes

    def full_name
        "#{first_name} #{last_name}"
    end

    def can_delete?(recipe)
        recipe.authored_by?(id)
    end
end
