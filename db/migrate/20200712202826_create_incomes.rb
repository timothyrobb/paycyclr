class CreateIncomes < ActiveRecord::Migration[6.0]
  def change
    create_table :incomes do |t|
      t.integer :amount
      t.string :frequency
      t.string :name

      t.timestamps
    end
  end
end
