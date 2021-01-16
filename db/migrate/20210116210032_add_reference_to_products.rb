class AddReferenceToProducts < ActiveRecord::Migration[6.1]
  def change
  	add_reference :products, :user_db
  end
end
