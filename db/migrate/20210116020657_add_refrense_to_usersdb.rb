class AddRefrenseToUsersdb < ActiveRecord::Migration[6.1]
  def change
  	add_reference :users, :user_db
  end
end
