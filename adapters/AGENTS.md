# Flutter Agent Rules — Codex Adapter

> Codex (OpenAI) lee este archivo automáticamente como `AGENTS.md`.
> Las reglas viven en `.agents/`; **no duplicar aquí**.

## Qué hacer al iniciar

1. Leer `.agents/AGENTS.md` completo antes de responder o editar.
2. Si no existe `overview/` en la raíz del proyecto → crearla desde `.agents/templates/`.
3. Cargar: `overview/session.md`, `overview/work.md`, `overview/work/tasks.md`.
4. Si el agente anterior fue distinto → activar protocolo Handoff (`core/brain.md §Handoff`).

## Qué hacer al trabajar

- Actualizar automáticamente todos los archivos de control en `overview/` (`work.md`, `tasks.md`, `session.md`, `pendientes.md`, `deuda_tecnica.md`, `work_review.md`, `architecture.md`) **antes** de editar código.
- Cambios quirúrgicos: no mejorar código ajeno sin necesidad.
- Referencias rápidas: `$boot` `$status` `$work` `$archi` `$learn` `$learnagnostico` `$close` (ver `.agents/core/commands.md`).

## Qué hacer al cerrar

1. Sincronizar automáticamente todos los archivos de control en `overview/` (`session.md`, `work.md`, `tasks.md`, `pendientes.md`, `deuda_tecnica.md`, `work_review.md`, `architecture.md`).
2. Registrar firma en `session.md`: `[Modelo] — YYYY-MM-DD`.
3. Indicar validación: `verificado` | `no verificado` | `no aplica`.

> Estado del proyecto → `overview/`. Reglas globales → `.agents/`. No duplicar.
