class AddTokenToUser < ActiveRecord::Migration[6.1]
  def change
  	add_reference :tokens, :user
  end
end
