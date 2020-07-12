class ChangeIncomeSourceAmountToAmountCents < ActiveRecord::Migration[6.0]
  def change
    remove_column :income_sources, :amount
    add_monetize :income_sources, :amount
  end
end
