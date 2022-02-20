class CreateOrderHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :order_histories do |t|
      t.integer :customers_id
      t.string :postal_code
      t.integer :address
      t.integer :name
      t.integer :postage
      t.integer :total_amount
      t.integer :method_of_payment
      t.integer :order_status
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
