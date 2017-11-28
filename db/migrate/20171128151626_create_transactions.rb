class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.string :invoice_id
      t.string :credit_card_number
      t.integer :result, default: 0
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
