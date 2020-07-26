class CreateFrequencies < ActiveRecord::Migration[6.0]
  def change
    create_table :frequencies do |t|
      t.string :name
      t.string :slug, index: true
      t.integer :base_days
      t.integer :amount, default: 1, null: :false

      t.timestamps
    end
  end
end
