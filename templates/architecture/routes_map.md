# 🧭 Mapa Global de Rutas y Navegación

> Pertenece a: `overview/architecture/routes_map.md`  
> Referenciado desde: [`ARCHITECTURE.md`](../../ARCHITECTURE.md)

## 1. Diagrama Sintético de Enrutamiento

```mermaid
graph TD
    ROOT[/] --> AUTH[/auth]
    ROOT --> DASHBOARD[/dashboard]
    DASHBOARD --> MODULE_MAIN[/principal]
```

## 2. Definición de Rutas Registradas

| Ruta | Pantalla / Vista | Guard / Parámetros |
|---|---|---|
| `/` | SplashScreen / Root | Redirección inicial |
| `/dashboard` | DashboardScreen | Auth Guard |
