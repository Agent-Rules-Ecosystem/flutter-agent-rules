---
name: mermaid-diagrams
description: Standardized rules for generating concise Mermaid diagrams for route tracking and system architecture.
---

# Mermaid Diagrams Skill

## 1. Reglas de Ahorro de Tokens
- Usar identificadores cortos para nodos (`w1`, `w2`, `s1`, `mod1`).
- Evitar etiquetas extremadamente largas dentro de los corchetes.
- Agrupar subgráficos solo cuando la complejidad del módulo lo requiera.

## 2. Clases Estándar de Estado (Tracker)
Definir siempre las clases al inicio del diagrama de rastreo:

```mermaid
graph TD
    classDef done fill:#2e7d32,stroke:#fff,color:#fff;
    classDef pending fill:#c62828,stroke:#fff,color:#fff;

    root[lib/features]:::done --> feature1[feature_a/]:::done
    feature1 --> screen1[screen.dart]:::done
    feature1 --> widget1[widgets.dart]:::pending
```

## 3. Actualización Incremental
- Al completar una tarea o refactorización, cambiar la clase del nodo individual de `:::pending` a `:::done`.
- El agente utilizará el primer nodo `:::pending` del diagrama como punto de reanudación en la siguiente sesión.
