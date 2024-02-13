class CreateRecipeAttempts < ActiveRecord::Migration[7.1]
  TABLE_NAME = 'recipe_attempts'
  def change
    create_table TABLE_NAME do |t|
      t.belongs_to :recipes
      t.belongs_to :users
      t.string :variation
      t.string :outcome
      t.string :next_time
      t.string :media_dir
      t.timestamps
    end
  end
end
