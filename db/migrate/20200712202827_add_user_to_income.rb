class AddUserToIncome < ActiveRecord::Migration[6.0]
  def change
    change_table :incomes do |t|
      t.references :user, index: true
    end
  end
end
