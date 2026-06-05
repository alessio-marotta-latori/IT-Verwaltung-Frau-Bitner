class DropDeviceTriggers < ActiveRecord::Migration[8.0]
  def up
    execute "DROP TRIGGER IF EXISTS trg_devices_after_insert;"
    execute "DROP TRIGGER IF EXISTS trg_devices_after_update;"
    execute "DROP TRIGGER IF EXISTS trg_devices_after_delete;"
  end

  def down
    execute <<-SQL
      CREATE TRIGGER IF NOT EXISTS trg_devices_after_insert
      AFTER INSERT ON devices
      BEGIN
        INSERT INTO activity_logs (action, trackable_type, trackable_id, details, created_at, updated_at)
        VALUES ('INSERT', 'Device', NEW.id,
          'hostname=' || COALESCE(NEW.hostname,'') || ', ip=' || COALESCE(NEW.ip_address,'') || ', type=' || COALESCE(NEW.device_type,''),
          datetime('now'), datetime('now'));
      END;
    SQL
    execute <<-SQL
      CREATE TRIGGER IF NOT EXISTS trg_devices_after_update
      AFTER UPDATE ON devices
      BEGIN
        INSERT INTO activity_logs (action, trackable_type, trackable_id, details, created_at, updated_at)
        VALUES ('UPDATE', 'Device', NEW.id,
          'old_hostname=' || COALESCE(OLD.hostname,'') || ' -> ' || COALESCE(NEW.hostname,'') ||
          ', old_ip=' || COALESCE(OLD.ip_address,'') || ' -> ' || COALESCE(NEW.ip_address,''),
          datetime('now'), datetime('now'));
      END;
    SQL
    execute <<-SQL
      CREATE TRIGGER IF NOT EXISTS trg_devices_after_delete
      AFTER DELETE ON devices
      BEGIN
        INSERT INTO activity_logs (action, trackable_type, trackable_id, details, created_at, updated_at)
        VALUES ('DELETE', 'Device', OLD.id,
          'hostname=' || COALESCE(OLD.hostname,'') || ', ip=' || COALESCE(OLD.ip_address,'') || ', type=' || COALESCE(OLD.device_type,''),
          datetime('now'), datetime('now'));
      END;
    SQL
  end
end
