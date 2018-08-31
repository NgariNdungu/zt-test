class CreateTransfers < ActiveRecord::Migration[5.0]
  def change
    create_table :transfers do |t|
      t.references :sender
      t.references :recipient
      t.integer :amount

      t.timestamps
    end
  end
end
