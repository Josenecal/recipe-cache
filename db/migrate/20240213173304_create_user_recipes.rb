class CreateUserRecipes < ActiveRecord::Migration[7.1]
  TABLE_NAME = 'user_recipes'
  def change
    create_table TABLE_NAME do |t|
      t.belongs_to :user
      t.belongs_to :recipe
      t.boolean :favorite, default: false
      t.timestamps
    end
  end
end
