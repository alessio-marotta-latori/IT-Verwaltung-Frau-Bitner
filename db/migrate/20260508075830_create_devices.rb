class CreateDevices < ActiveRecord::Migration[8.0]
  def change
    create_table :devices do |t|
      t.string :hostname
      t.string :ip_address
      t.string :mac_address
      t.string :device_type
      t.string :serial_number
      t.date :purchase_date
      t.date :warranty_until
      t.boolean :active
      t.text :notes

      t.timestamps
    end
  end
end
