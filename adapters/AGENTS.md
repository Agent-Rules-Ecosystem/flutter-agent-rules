# Flutter Agent Rules — Codex Adapter

> Codex (OpenAI) lee este archivo automáticamente como `AGENTS.md`.
> Las reglas viven en `.agents/`; **no duplicar aquí**.

## Qué hacer al iniciar

1. Leer `.agents/AGENTS.md` completo antes de responder o editar.
2. Si no existe `overview/` en la raíz del proyecto → crearla desde `.agents/templates/`.
3. Aplicar el **Protocolo de Carga en 3 Capas** (`core/brain.md`): cargar **Capa 1** (`overview/session.md`, `overview/work.md`) y cargar **Capa 2/3** (`tasks.md`, `deuda_tecnica.md`, `pendientes.md`, `architecture/`) solo bajo demanda.
4. Si el agente anterior fue distinto → activar protocolo Handoff (`core/brain.md §Handoff`).

## Qué hacer al trabajar

- Sincronizar automáticamente los archivos de control afectados en `overview/` **antes** de editar código y al finalizar.
- Cambios quirúrgicos: no mejorar código ajeno sin necesidad.
- Referencias rápidas: `$boot` `$status` `$work` `$archi` `$learn` `$learnagnostico` `$learnskill` `$revlearnskill` `$laconico` `$modo:detallado` `$close` (ver `.agents/core/commands.md`).

## Qué hacer al cerrar

1. Sincronizar automáticamente los archivos de control afectados en `overview/`.
2. Registrar firma en `session.md`: `[Proveedor Modelo — YYYY-MM-DD]`.
3. Indicar validación: `verificado` | `no verificado` | `no aplica`.

> Estado del proyecto → `overview/`. Reglas globales → `.agents/`. No duplicar.
