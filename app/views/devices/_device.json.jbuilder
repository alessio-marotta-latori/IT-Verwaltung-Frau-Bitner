json.extract! device, :id, :hostname, :ip_address, :mac_address, :device_type, :serial_number, :purchase_date, :warranty_until, :active, :notes, :created_at, :updated_at
json.url device_url(device, format: :json)
