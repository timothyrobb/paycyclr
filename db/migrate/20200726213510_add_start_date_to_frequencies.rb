class AddStartDateToFrequencies < ActiveRecord::Migration[6.0]
  def change
    change_table :frequencies do |t|
      t.datetime :start_date
      t.remove :base_days
      t.remove :name
    end
  end
end
