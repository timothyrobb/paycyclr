class AllowPaymentsWithoutFrequency < ActiveRecord::Migration[6.0]
  def change
    change_column_null :payments, :frequency_id, true
  end
end
