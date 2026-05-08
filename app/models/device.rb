class Device < ApplicationRecord
  after_create :log_create
  after_update :log_update

  private

  def log_create
    ActivityLog.create(action: "Neu angelegt", trackable_id: self.id, details: self.attributes.to_s)
  end

  def log_update
    ActivityLog.create(action: "Geändert", trackable_id: self.id, details: self.saved_changes.to_s)
  end
end
