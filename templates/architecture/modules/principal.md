# 📦 Módulo: Principal

> Pertenece a: `overview/architecture/modules/principal.md`  
> Referenciado desde: [`ARCHITECTURE.md`](../../ARCHITECTURE.md)

## 1. Mapa de Enrutamiento Lógico y Flujo Operativo

```mermaid
graph TD
    VIEW[Principal Screen] --> PROVIDER[Principal Provider / Notifier]
    PROVIDER --> CASO_USO[Caso de Uso Principal]
    CASO_USO --> REPO[Repositorio Principal]
```

## 2. Reglas de Negocio del Módulo
* **Regla 1:** Explicación técnica de la regla.
* **Regla 2:** Explicación técnica de la regla.

## 3. Componentes y Servicios Clave
* **Pantallas:** `lib/presentation/screens/principal/`
* **Widgets:** `lib/presentation/screens/principal/widgets/`
* **Servicios / Notifiers:** `lib/presentation/providers/`

## 4. Estado Actual de Refactorización
* [x] Componentes modulares (< 250L por archivo)
* [x] Pruebas y análisis de estática limpios (`0 issues`)
