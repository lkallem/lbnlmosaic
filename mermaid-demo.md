---
layout: page
title: Mermaid Demo
permalink: /mermaid-demo/
nav_order: 4
---

## Mermaid Diagram Examples

This page demonstrates the built-in Mermaid diagram support in the LBNL Jekyll template.

### Research Process Flowchart

```mermaid
flowchart TD
    A[Research Question] --> B[Literature Review]
    B --> C[Hypothesis Formation]
    C --> D[Experimental Design]
    D --> E[Data Collection]
    E --> F[Data Analysis]
    F --> G{Results Significant?}
    G -->|Yes| H[Write Publication]
    G -->|No| I[Refine Hypothesis]
    I --> D
    H --> J[Peer Review]
    J --> K[Publication]
```

### Laboratory System Architecture

```mermaid
graph TB
    subgraph "Data Acquisition"
        A[Sensors] --> B[Data Logger]
        B --> C[Local Database]
    end
    
    subgraph "Processing"
        C --> D[Analysis Pipeline]
        D --> E[Quality Control]
        E --> F[Machine Learning Model]
    end
    
    subgraph "Visualization"
        F --> G[Dashboard]
        F --> H[Reports]
        F --> I[Alerts]
    end
    
    style A fill:#00313C,stroke:#007681,color:#ffffff
    style G fill:#D57800,stroke:#00313C,color:#ffffff
    style H fill:#74AA50,stroke:#00313C,color:#ffffff
```

### Project Timeline

```mermaid
gantt
    title Research Project Timeline
    dateFormat YYYY-MM-DD
    section Literature Review
    Background Research    :done, lit1, 2024-01-01, 2024-02-15
    Gap Analysis          :done, lit2, after lit1, 30d
    
    section Experimental Phase
    Equipment Setup       :active, exp1, 2024-03-01, 45d
    Data Collection       :exp2, after exp1, 90d
    Initial Analysis      :exp3, after exp2, 30d
    
    section Publication
    Draft Writing         :pub1, after exp3, 45d
    Peer Review          :pub2, after pub1, 60d
    Final Publication    :milestone, pub3, after pub2, 0d
```

### System State Diagram

```mermaid
stateDiagram-v2
    [*] --> Idle
    
    Idle --> Calibrating: Start Calibration
    Calibrating --> Ready: Calibration Complete
    Calibrating --> Error: Calibration Failed
    
    Ready --> Measuring: Begin Measurement
    Measuring --> Processing: Data Collected
    Processing --> Ready: Results Generated
    Processing --> Error: Processing Failed
    
    Error --> Idle: Reset System
    Ready --> Idle: Shutdown
```

### Class Diagram (Software Architecture)

```mermaid
classDiagram
    class DataCollector {
        +String deviceId
        +DateTime timestamp
        +collect() List~DataPoint~
        +calibrate() Boolean
        +getStatus() Status
    }
    
    class DataProcessor {
        +process(data) ProcessedData
        +validate(data) Boolean
        +exportResults() File
    }
    
    class Dashboard {
        +display(data) void
        +updateCharts() void
        +generateReport() Report
    }
    
    DataCollector "1" --> "many" DataProcessor
    DataProcessor "1" --> "1" Dashboard
    
    class DataPoint {
        +Double value
        +DateTime timestamp
        +String unit
        +validate() Boolean
    }
    
    DataCollector --> DataPoint
```

### Sequence Diagram (User Interaction)

```mermaid
sequenceDiagram
    participant U as User
    participant D as Dashboard
    participant P as Processor
    participant S as Sensor
    
    U->>D: Request measurement
    D->>P: Initialize processing
    P->>S: Start data collection
    
    loop Every 1 second
        S->>P: Send data point
        P->>P: Validate data
    end
    
    P->>D: Send processed results
    D->>U: Display results
    
    Note over U,S: Real-time data monitoring
    
    alt Error occurs
        S->>P: Send error signal
        P->>D: Report error
        D->>U: Show error message
    end
```

### Git Workflow

```mermaid
gitGraph
    commit id: "Initial setup"
    branch develop
    checkout develop
    commit id: "Add data collection"
    commit id: "Implement processing"
    checkout main
    merge develop
    commit id: "Release v1.0"
    
    branch feature/ml
    checkout feature/ml
    commit id: "Add ML pipeline"
    commit id: "Train models"
    checkout develop
    merge feature/ml
    commit id: "Integration tests"
    checkout main
    merge develop
    commit id: "Release v2.0"
```
