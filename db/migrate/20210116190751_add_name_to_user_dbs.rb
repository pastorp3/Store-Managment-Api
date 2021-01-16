class AddNameToUserDbs < ActiveRecord::Migration[6.1]
  def change
  	add_column :user_dbs, :name, :string
  end
end
