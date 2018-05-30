class ChangeTypeOfPrice < ActiveRecord::Migration[5.2]
  def change
    change_column :stocks, :last_price, :float
  end
end
