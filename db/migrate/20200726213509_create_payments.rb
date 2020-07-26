class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.string :type
      t.string :name
      t.string :account
      t.integer :amount
      t.datetime :due_date
      t.boolean :optional, null: false, default: false
      t.datetime :skipped_at
      t.references :schedule, foreign_key: { to_table: :payments }
      t.references :user, null: false, foreign_key: true
      t.references :frequency, null: false, foreign_key: true

      t.timestamps
    end
  end
end
