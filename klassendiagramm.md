# Klassendiagramm – IT-Verwaltung

```mermaid
classDiagram

    %% ── Rails-Basisklassen ──────────────────────────────────────
    class ActiveRecordBase {
        <<Rails Framework>>
    }

    class ActionControllerBase {
        <<Rails Framework>>
    }

    %% ── Abstrakte Basisklassen ──────────────────────────────────
    class ApplicationRecord {
        <<abstract>>
        primary_abstract_class
    }

    class ApplicationController {
        +allow_browser()
    }

    %% ── Models ──────────────────────────────────────────────────
    class Device {
        +String hostname
        +String ip_address
        +String mac_address
        +String device_type
        +String serial_number
        +Date purchase_date
        +Date warranty_until
        +Boolean active
        +String notes
        --
        +DEVICE_TYPES$ String[]
        --
        -log_create()
        -log_update()
        -log_destroy()
    }

    class ActivityLog {
        +String action
        +String trackable_type
        +Integer trackable_id
        +String details
        +DateTime created_at
        +DateTime updated_at
    }

    %% ── Controllers ─────────────────────────────────────────────
    class DevicesController {
        -Device[] @devices
        -Device @device
        --
        +index()
        +show()
        +new()
        +edit()
        +create()
        +update()
        +destroy()
        --
        -set_device()
        -device_params()
    }

    class ActivityLogsController {
        -ActivityLog[] @activity_logs
        --
        +index()
    }

    %% ── Vererbung ───────────────────────────────────────────────
    ActiveRecordBase      <|-- ApplicationRecord
    ApplicationRecord     <|-- Device
    ApplicationRecord     <|-- ActivityLog

    ActionControllerBase  <|-- ApplicationController
    ApplicationController <|-- DevicesController
    ApplicationController <|-- ActivityLogsController

    %% ── Assoziationen ───────────────────────────────────────────
    Device              ..> ActivityLog  : "after_create / after_update\nafter_destroy\n→ ActivityLog.create()"
    DevicesController   --> Device       : "verwendet"
    ActivityLogsController --> ActivityLog : "verwendet"
```

## Hinweise

| Beziehung | Typ | Erklärung |
|---|---|---|
| `Device` → `ActivityLog` | Abhängigkeit (gestrichelt) | `Device` erstellt per Callback (`after_create` etc.) neue `ActivityLog`-Einträge. Kein echter Fremdschlüssel – polymorphe Assoziation über `trackable_type` / `trackable_id`. |
| `DevicesController` → `Device` | Assoziation | Controller instanziiert und verwendet das Model direkt. |
| `ActivityLogsController` → `ActivityLog` | Assoziation | Controller liest alle Logs aus der Datenbank. |
| `ApplicationRecord` ← `ActiveRecord::Base` | Vererbung | Rails-Basisklasse für alle Models. |
| `ApplicationController` ← `ActionController::Base` | Vererbung | Rails-Basisklasse für alle Controller. |
