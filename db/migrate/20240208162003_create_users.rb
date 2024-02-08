class CreateUsers < ActiveRecord::Migration[7.1]
  TABLE_NAME = 'users'
  def change
    create_table TABLE_NAME do |t|
      t.string 'first_name'
      t.string 'last_name'
      t.integer 'zip_code'
      t.string 'email'
      t.string 'password'
      t.timestamps
    end
  end
end
