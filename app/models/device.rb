require "csv"

class Device < ApplicationRecord
  DEVICE_TYPES = [ "Desktop", "Laptop", "Switch", "Printer", "Access Point", "Server", "NAS-System" ].freeze

  after_create :log_create
  after_update :log_update
  after_destroy :log_destroy

  validates :hostname, presence: true, uniqueness: true
  validates :ip_address, presence: true,
    format: { with: /\A\d{1,3}(\.\d{1,3}){3}\z/, message: "muss ein gültiges IPv4-Format haben (z.B. 192.168.1.10)" }
  validates :mac_address, presence: true,
    format: { with: /\A([0-9A-Fa-f]{2}[:\-]){5}[0-9A-Fa-f]{2}\z/, message: "muss ein gültiges Format haben (z.B. AA:BB:CC:DD:EE:FF)" }
  validates :device_type, presence: true, inclusion: { in: DEVICE_TYPES }

  def self.to_csv
    headers = %w[Hostname IP-Adresse MAC-Adresse Typ Seriennummer Kaufdatum Garantie_bis Aktiv Notizen]
    ::CSV.generate(headers: true) do |csv|
      csv << headers
      all.each do |device|
        csv << [
          device.hostname, device.ip_address, device.mac_address,
          device.device_type, device.serial_number, device.purchase_date,
          device.warranty_until, device.active, device.notes
        ]
      end
    end
  end

  private

  def log_create
    ActivityLog.create(action: "Neu angelegt", trackable_type: "Device", trackable_id: id, details: attributes.to_json)
  end

  def log_update
    ActivityLog.create(action: "Geändert", trackable_type: "Device", trackable_id: id, details: saved_changes.to_json)
  end

  def log_destroy
    ActivityLog.create(action: "Gelöscht", trackable_type: "Device", trackable_id: id, details: attributes.to_json)
  end
end
