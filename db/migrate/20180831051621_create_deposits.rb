class CreateDeposits < ActiveRecord::Migration[5.0]
  def change
    create_table :deposits do |t|
      t.references :user, foreign_key: true
      t.integer :amount

      t.timestamps
    end
  end
end
