class ChangeFrequencyToReferenceOnIncomeSources < ActiveRecord::Migration[6.0]
  def change
    change_table :income_sources do |t|
      t.remove :frequency
      t.references :frequency
    end
  end
end
