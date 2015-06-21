class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.string :state, default: 'created'
      t.string :description
      t.string :generated_id
      t.string :brand
      t.string :model
      t.string :complect
      t.string :serial
      t.string :condition
      t.integer :phone
      t.string :about
      t.integer :base_price
      t.integer :our_price
      t.string :our_serial

      t.timestamps null: false
    end
  end
end
