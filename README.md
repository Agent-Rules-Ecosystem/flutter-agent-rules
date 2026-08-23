# 🚀 Flutter Agent Rules

**Cerebro operativo centralizado para agentes de IA en proyectos Flutter**. Diseñado para maximizar el ahorro de tokens, mantener la memoria entre sesiones y modelos, garantizar la trazabilidad de código y mantener una arquitectura viva sincronizada.

Se instala como submódulo de Git en `.agents/`. Las reglas globales son 100% agnósticas e independientes del código fuente del proyecto.

---

## ⚡ Quickstart (TL;DR — 1 minuto)

### 1. Agrega la gobernanza a tu proyecto
```bash
git submodule add https://github.com/Agent-Rules-Ecosystem/flutter-agent-rules.git .agents
```

### 2. Inicia el ciclo en el chat de tu Agente (Cursor, Antigravity, Claude, etc.)
```text
$boot
```

### 3. Ejecuta tareas y registra el avance
```text
$work [descripción de la tarea]
```

### 4. Cierra la sesión y sincroniza la memoria del proyecto
```text
$close
```

---

## 📌 Pilares de Gobernanza

1. **⚡ Modo Cavernícola & Token Saver**: Respuestas ultra-concisas, eliminación de prosa innecesaria y referencias de líneas en lugar de duplicación de código en chat.
2. **🔄 Sincronización Automática de Rastreadores**: Actualización simultánea e integral de los 7 archivos de control en `overview/` (`session.md`, `work.md`, `tasks.md`, `pendientes.md`, `deuda_tecnica.md`, `work_review.md` y `architecture.md`) durante `$work` y `$close`, sin requerir recordatorio manual del usuario.
3. **🗺️ Arquitectura Viva (`$archi`)**: Mantenimiento incremental del mapa técnico en `overview/architecture.md` mediante **diagramas sintéticos Mermaid** (`graph LR` / `graph TD`) sin texto redundante, para lectura rápida y rastreo de conexiones.
4. **👥 Handoff y Memoria Versionada por Agente**: Firma canónica por proveedor/modelo (`[Proveedor] [Modelo] — YYYY-MM-DD`). Historial incremental de solución de bugs y traspaso transparente al cambiar de agente.
5. **🛡️ Escudo Anti-parches (Filtro Agnóstico)**: Las mejoras al core prohiben código específico o comandos CLI rígidos; únicamente procesos de diagnóstico y gobernanza agnósticos.
6. **🔒 Inviolabilidad de `.agents/`**: Los archivos de gobernanza en `.agents/` nunca se modifican desde el proyecto local. Todo aprendizaje candidato se plasma en `overview/learning.md` bajo `## 📌 Propuestas de mejora` y se promueve al repositorio oficial con aprobación del propietario.

---

## ⚡ $-Comandos (Orden de Flujo de Trabajo)

Los $-comandos son atajos explícitos que ejecutan protocolos inmediatos en el proyecto:

| Comando | Tipo | Descripción y Flujo |
|---|---|---|
| `$boot` | **Inicio** | Bootstrap completo, lectura de reglas, verificación de `overview/` y handoff de agente. |
| `$status` | **Inspección** | Muestra el estado activo en 5 líneas (Agente, Nodo, Validación, Tareas abiertas y Próximo paso). |
| `$work [descripción]` | **Ejecución** | Registra tarea/bug en `work.md`, abre `tasks.md` y sincroniza automáticamente los 7 rastreadores. |
| `$archi` | **Arquitectura** | Escanea cambios estructurales de la sesión y actualiza **diagramas Mermaid sintéticos** (sin texto redundante) y capas en `architecture.md`. |
| `$learn [texto]` | **Aprendizaje** | Valida con Filtro Agnóstico y registra propuesta de mejora candidata en `overview/learning.md`. |
| `$learnagnostico [texto]` | **Abstracción** | Descontextualiza entidades de negocio a términos agnósticos y las registra en `overview/learning.md`. |
| `$close` | **Cierre** | Cierre de sesión, validación de calidad/tests, registro de pendientes y sincronización final de rastreadores. |
| `ejecuta .agents` | **Auditoría** | Dispara el bootstrap completo más la Evaluación de 3 Vías de `overview/learning.md`. |

---

## 📂 Estructura Canónica de `overview/`

El estado del proyecto vive en la raíz del repositorio huésped dentro del directorio `overview/` (creado desde `.agents/templates/`):

```
overview/
├── session.md             # Sesión activa, firma de Agente y puntos de reanudación
├── work.md                # Índice maestro de tareas, bugs y backlog canónico único
├── architecture.md        # Mapa de Arquitectura Viva (Diagramas Mermaid y capas)
├── work_review.md         # Reporte de revisión mutable generado al final de $boot
├── work/
│   ├── tasks.md           # Tarea activa en ejecución, soluciones y rutas
│   ├── pendientes.md      # Seguimiento de tareas identificadas al cerrar ($close)
│   └── deuda_tecnica.md   # Deuda clasificada por prioridad (Alta, Media, Baja)
├── trackers/
│   ├── progress.md        # Progreso general por nodos de avance
│   └── architecture.md    # Registro incremental de nodos de arquitectura
├── context/               # Datos de dominio, changelogs y metadatos no mapeables
├── workflows/             # Guías de dominio agnósticas (ej. Origen → Procesamiento → Destino)
├── learning.md            # Propuestas de mejora candidatas al core
└── history/               # Histórico de sesiones anteriores archivadas
```

---

## 📦 Instalación y Configuración

### 1. Agregar submódulo en el proyecto Flutter

```bash
git submodule add https://github.com/Agent-Rules-Ecosystem/flutter-agent-rules.git .agents
```

### 2. Copiar adaptador según la herramienta de IA

Copiar el adaptador correspondiente desde `.agents/adapters/` a la raíz de su entorno:

- **OpenAI / Codex**: `adapters/AGENTS.md` → `AGENTS.md`
- **Claude**: `adapters/CLAUDE.md` → `CLAUDE.md`
- **Gemini / Antigravity**: `adapters/GEMINI.md` → `GEMINI.md`
- **Cursor**: `adapters/cursor-rule.mdc` → `.cursor/rules/agents.mdc`

### 3. Iniciar el proyecto

Escribir en la primera interacción del agente:

```text
$boot
```

El agente creará la estructura `overview/` desde `.agents/templates/` e iniciará el ciclo de trabajo.

---

## 🔍 Contenido Contrastado y Verificación

Cuando múltiples agentes participan en una tarea, los datos de dominio se verifican entre sí:
- **`verificado`**: 2+ agentes coinciden, las fuentes son compatibles y no existen conflictos abiertos.
- **`conflicto`**: Discrepancias abiertas entre fuentes o agentes; requiere resolución explícita.
- **`no aplica`**: Proyectos o módulos sin suite de pruebas automatizadas.
