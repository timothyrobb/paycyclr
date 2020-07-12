class ChangeIncomesToIncomeSources < ActiveRecord::Migration[6.0]
  def change
    rename_table :incomes, :income_sources
  end
end
