class AddPrivateToRecipes < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :private, :boolean, default: false
  end
end
