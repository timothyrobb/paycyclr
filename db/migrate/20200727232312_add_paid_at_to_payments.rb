class AddPaidAtToPayments < ActiveRecord::Migration[6.0]
  def change
    add_column :payments, :paid_at, :datetime
  end
end
