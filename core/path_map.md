# Mapa canónico de rutas

## Reglas globales: submódulo `.agents/`

| Recurso | Ruta | Carga |
|---|---|---|
| Comunicación | `.agents/core/communication.md` | Obligatoria — **leer primero** |
| Router | `.agents/AGENTS.md` | Obligatoria |
| Brain | `.agents/core/brain.md` | Obligatoria |
| Comandos | `.agents/core/commands.md` | Obligatoria |
| Adaptadores (Codex / Cursor / etc) | `.agents/adapters/` (`AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `cursor-rule.mdc`, `README.md`) | Al instalar |
| Estructura Flutter | `.agents/knowledge/flutter_structure.md` | Discovery |
| Estilo Dart / Clean Arch | `.agents/knowledge/code_style.md` | Bajo demanda |
| Referencia Capas Arquitectura | `.agents/knowledge/architecture.md` | Bajo demanda |
| Release Checklist | `.agents/knowledge/release_checklist.md` | `$close` / Build |
| Plantillas `overview/` | `.agents/templates/` | `$boot` / Inicio |
| Skill Clean Arch & Limits | `.agents/skills/flutter-clean-arch/SKILL.md` | Refactors / UI |
| Skill Diagrams Mermaid | `.agents/skills/mermaid-diagrams/SKILL.md` | Diagramación |
| Skills específicas del proyecto | `.skill/<skill_name>/SKILL.md` (submódulo del repo huésped) | Bajo demanda — escaneo automático en `$boot` |

> **Gobernanza de Skills por Proyecto**: Skills específicas de un proyecto deben gestionarse como submódulo independiente en `.skill/<skill_name>/` (raíz del repo huésped, **fuera** de `.agents/`). Esto evita el error de Git que ocurre al intentar registrar un submódulo anidado dentro de otro submódulo (`.agents/`).

> **Repo oficial (`flutter-agent-rules`)**: Al editar este repositorio directamente, las rutas `.agents/core/…` equivalen a `core/…`, `.agents/templates/` a `templates/`, etc. No existe el prefijo `.agents/` en la raíz de este repo.

## Estado local: raíz del proyecto

| Recurso | Ruta | Carga |
|---|---|---|
| Sesión | `overview/session.md` | Inicio/cierre |
| Trabajo (Índice Maestro) | `overview/work.md` | Inicio/cierre |
| Tarea Activa | `overview/work/tasks.md` | Inicio/en ejecución |
| Pendientes | `overview/work/pendientes.md` | Cierre/bajo demanda |
| Deuda Técnica | `overview/work/deuda_tecnica.md` | Inicio/bajo demanda |
| Protocolo Revisión Work | `overview/work_review.md` | Fin de `$boot` |
| Aprendizajes | `overview/learning.md` | Al cerrar |
| Arquitectura real | `overview/architecture.md` | Inicio / `$archi` / `$close` |
| Tracker Arquitectura | `overview/trackers/architecture.md` | Bajo demanda |
| Tracker Progreso | `overview/trackers/progress.md` | Inicio/cierre |
| Contenido | `overview/trackers/content_*.md` | Si aplica |
| Modularización Contenido | `overview/trackers/content/<cat>/<item>.md` | Bajo demanda |
| Historial | `overview/history/` | Al resumir |
| Contexto de dominio | `overview/context/` | Inicio/bajo demanda |
| Flujos de dominio | `overview/workflows/` | Bajo demanda |

> `overview/context/` es para archivos de dominio no mapeables al framework ni al estado de sesión: contexto general, changelogs de contenido, datos de referencia de la app. Se leen al reanudar como checkpoints.

> `overview/workflows/` es la **ubicación canónica** para registrar guías de dominio por flujo en términos agnósticos (ej. materia prima: `Entrada → Inventario → Producción`). Se mantiene estrictamente separada de `overview/architecture.md` (mapa de arquitectura técnica de código) y de `overview/context/` (datos de negocio / archivos de referencia general).

### Backlog canónico único y Prioridad de atención

- `overview/work.md` = **único** índice y tabla maestra de IDs (`tarea` / `bug` / `deuda`).
- **Orden de prioridad de atención en `$work`**:
  1. `overview/work/tasks.md` (tarea activa en ejecución)
  2. `overview/work/pendientes.md` (ítems de seguimiento identificados)
  3. `overview/work/deuda_tecnica.md` (deuda ordenada por prioridad **Alta**, **Media** y **Baja**)
- **Histórico de completados**: Al resolver cualquier ítem de trabajo (tarea, bug o deuda), retirarlo inmediatamente de las tablas activas y trasladarlo a `## ✅ Completados (Historial)` en `work.md`, `deuda_tecnica.md` y `pendientes.md` conservando su ID (`[w1]`, `[d2]`, `[p1]`).
- No duplicar detalles en el alias heredado `tasks.md` ni escribir backlogs paralelos fuera del esquema canónico.

## Alias heredados

| Alias | Ruta actual |
|---|---|
| `overview/tracker.md` | `overview/trackers/architecture.md` |
| `overview/tasks.md` (raíz) | `overview/work.md` / `overview/work/tasks.md` |
| `memory_session.md` | `overview/session.md` |

> Si coexisten alias y canónico con contenido distinto (ej. `tasks.md`/`work.md` o `tracker.md`/`trackers/architecture.md`) → flag `[consolidar alias]` obligatorio (`brain.md`). Nunca asumir cuál manda sin verificar diff previo.
