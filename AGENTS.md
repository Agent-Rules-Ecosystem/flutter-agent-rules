---
name: agent-rules-governance
description: Bootstrap and governance for shared Flutter agent rules.
---

# Flutter Agent Rules

## Bootstrap obligatorio

Antes de responder o editar, leer y cumplir:

1. `.agents/core/communication.md` ← **primero siempre; rige todo lo que sigue**
2. `.agents/core/path_map.md`
3. `.agents/core/brain.md`
4. `.agents/core/commands.md`

**Triggers de arranque** — las siguientes frases o condiciones disparan el protocolo completo (discovery + `overview/` + mapeo de archivos):

- **"ejecuta .agents"** (o "corre .agents", "bootstrap .agents") → dispara además el Protocolo de Auditoría de Learning definido en `brain.md`.
- "nuevo proyecto" / "inicializar" / "bootstrap" / "empieza" en el primer mensaje.
- Ausencia de `overview/session.md` al comenzar cualquier tarea de código.
- Primer mensaje de conversación cuando el proyecto tiene `.agents/` pero no `overview/`.
- Cualquier mensaje que comience con `$` → reconocer como $-comando según `core/commands.md` y ejecutar el protocolo correspondiente.

Para cualquier tarea que inspeccione o cambie código del proyecto, cargar el estado siguiendo el **Protocolo de Carga de Contexto en 3 Capas** (`core/brain.md`): iniciar con **Capa 1** (`overview/session.md` y `overview/work.md`) y cargar **Capa 2/3** (`overview/work/tasks.md`, `overview/work/deuda_tecnica.md`, `overview/work/pendientes.md`, `overview/trackers/progress.md`, `overview/architecture/` o `overview/work/skill/`) solo según lo exija la tarea o `work_review.md`. Sincronización automática de todos los archivos de control afectados en `overview/` durante `$work` y `$close` es obligatoria. Al finalizar o resolver una tarea proveniente de `pendientes.md` o `deuda_tecnica.md`, mover físicamente la fila correspondiente a `## ✅ Completados (Historial)` y actualizar `work.md`. Si falta `overview/`, crearlo desde `.agents/templates/`. Al finalizar `$boot`, ejecutar el protocolo `overview/work_review.md`.

Las reglas globales viven solo en `.agents/`. **Inviolabilidad estricta de `.agents/`**: Nunca modificar directamente archivos de gobernanza o comandos en `.agents/` desde un proyecto local. Todos los aprendizajes candidatos deben plasmarse únicamente en `overview/learning.md` bajo `## 📌 Propuestas de mejora`. Si el agente no descubre `.agents/AGENTS.md`, instalar adaptador mínimo desde `.agents/adapters/`; nunca duplicar reglas. Al editar este repositorio oficial directamente, usar rutas locales equivalentes (`core/`, `templates/`, etc.).

## Estado local versionado

Crear `overview/` desde `.agents/templates/` al iniciar proyecto. Cargar bajo demanda según el Protocolo de 3 Capas (`core/brain.md`) y sincronizar automáticamente los archivos afectados al cerrar:

- `overview/session.md`
- `overview/work.md` (índice maestro)
- `overview/work/tasks.md` (tarea activa: tipo, solución/rutas)
- `overview/work/pendientes.md` (seguimiento al cerrar)
- `overview/work/deuda_tecnica.md` (deuda ordenada por prioridad Alta, Media y Baja)
- `overview/work_review.md` (protocolo de auditoría `$boot`)
- `overview/commands_project.md` (catálogo sincronizado de `$-comandos` del proyecto)
- `overview/workflows/` (guías por flujo con terminología 100% agnóstica)
- `overview/trackers/progress.md`
- `overview/architecture.md` y `overview/architecture/` cuando aplique (actualizable vía `$archi` con diagramas Mermaid)
- `overview/context/` para archivos de contexto general no mapeables
- `overview/learning.md` cuando surja mejora candidata (propuestas al core)

`overview/history/` conserva sesiones antiguas. Cambios a reglas globales solo ocurren en repositorio oficial con aprobación del propietario.