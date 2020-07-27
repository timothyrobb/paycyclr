class ChangePaymentAmountToAmountCents < ActiveRecord::Migration[6.0]
  def change
    remove_column :payments, :amount
    add_monetize :payments, :amount
  end
end
