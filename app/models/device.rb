class Device < ApplicationRecord
  DEVICE_TYPES = ["Desktop", "Laptop", "Switch", "Printer", "Access Point", "Server", "NAS-System"].freeze

  after_create :log_create
  after_update :log_update
  after_destroy :log_destroy

  validates :hostname, presence: true, uniqueness: true
  validates :ip_address, presence: true
  validates :mac_address, presence: true
  validates :device_type, presence: true, inclusion: { in: DEVICE_TYPES }

  private

  def log_create
    ActivityLog.create(action: "Neu angelegt", trackable_type: "Device", trackable_id: self.id, details: self.attributes.to_s)
  end

  def log_update
    ActivityLog.create(action: "Geändert", trackable_type: "Device", trackable_id: self.id, details: self.saved_changes.to_s)
  end

  def log_destroy
    ActivityLog.create(action: "Gelöscht", trackable_type: "Device", trackable_id: self.id, details: self.attributes.to_s)
  end
end
