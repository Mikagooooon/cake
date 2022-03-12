class CreateOrderHistoryDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_history_details do |t|
      t.integer :order_id
      t.integer :item_id
      t.integer :unit_price
      t.integer :quantity
      t.integer :production_status
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
