class AddConstraintsToDevices < ActiveRecord::Migration[8.0]
  def change
    change_column_null :devices, :hostname, false
    change_column_null :devices, :ip_address, false
    change_column_null :devices, :mac_address, false
    change_column_null :devices, :device_type, false
    add_index :devices, :hostname, unique: true
  end
end
