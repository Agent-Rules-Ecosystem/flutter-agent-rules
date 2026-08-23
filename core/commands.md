# Comandos del Core ($-commands)

Cuando el usuario escribe un comando con prefijo `$`, el agente lo reconoce como instrucción explícita y ejecuta el protocolo correspondiente **inmediatamente**, sin esperar bootstrap automático.

> Propósito: compensar los casos donde el bootstrap automático fue incompleto o no se disparó.

---

## Referencia rápida

| Comando | Acción |
|---|---|
| `$boot` | Bootstrap completo del proyecto |
| `$status` | Mostrar estado actual en resumen |
| `$work [descripción]` | Registrar nueva tarea/bug |
| `$archi` | Actualizar arquitectura viva (diagramas Mermaid y conexiones) |
| `$learn [texto]` | Registrar aprendizaje general candidato en `overview/learning.md` |
| `$learnagnostico [texto]` | Abstraer a términos genéricos antes de registrar |
| `$learnskill [skill] [texto]` | Registrar propuesta de mejora etiquetada para una skill instalada |
| `$revlearnskill` | Revisión y promoción de propuestas (solo en el repo oficial `*-agent-rules`) |
| `$close` | Protocolo de cierre de sesión con sincronización automática de rastreadores |

---

## Definición de cada comando

### `$boot`

Dispara el bootstrap completo. Equivalente a **"ejecuta .agents"** pero más corto.

Pasos que el agente debe ejecutar:
0. Ejecutar `git submodule status` para verificar integridad de submódulos.
1. Leer `core/path_map.md`, `core/communication.md`, `core/brain.md`, `core/commands.md`.
2. Verificar si existe `overview/` — si no, crear desde `templates/`.
3. Cargar archivos de control de `overview/`: `session.md`, `work.md`, `work/tasks.md`, `work/deuda_tecnica.md`, `work/pendientes.md`, `work_review.md`, `architecture.md` y `trackers/progress.md`.
4. Detectar si el `Agente:` en `session.md` difiere del modelo actual → si difiere, activar protocolo `## Handoff de Agente` de `brain.md`.
5. Alias divergentes: si alias y canónico coexisten con contenido distinto (`tasks.md`/`work.md`, `tracker.md`/`trackers/architecture.md`) → flag `[consolidar alias]` en `work.md`.
6. `session.md` legado: si faltan `Agente:`, `## Reanudar` o `## Cambios` → reportar `session legado` (sin migrar automático).
7. Auditoría de líneas: listar archivos de código fuente >250L; sugerir IDs `deuda` en `overview/work/deuda_tecnica.md` (prioridades **Alta**, **Media**, **Baja**).
8. Auditar `overview/learning.md` (Protocolo de 3 Vías — ver `core/learning_protocol.md`): por cada bullet en `## 📌 Propuestas de mejora` evaluar si está ✅ aplicada (promover al `## 📜 Histórico`), ❌ rechazada (viola Filtro Agnóstico → eliminar), ⚠️ en conflicto con regla existente (flag `[conflicto learning: regla X]` en `work.md`) o ⏳ pendiente (conservar). Bullets con etiqueta `- [nombre-skill]` son propuestas para skills: ejecutar `$revlearnskill` en el governing repo cuando aplique.
9. **Generación (siempre) de `overview/commands_project.md`**: **Regenerar completo en cada `$boot`**, independientemente de si el archivo ya existe. El archivo anterior se sobreescribe. Protocolo:
   - Escribir encabezado con fecha/hora de actualización.
   - Copiar la tabla de referencia rápida de `core/commands.md` bajo `## 🧠 Comandos del Core`.
   - Escanear `.skill/` — para cada subdirectorio que contenga `core/commands.md`, agregar una sección `## 🧩 Comandos: [nombre-skill]` con su tabla de comandos leída en ese momento.
   - Si una skill fue eliminada de `.skill/`, su sección desaparece del archivo automáticamente.
   - Si una skill actualizó su `core/commands.md` (agregó, eliminó o editó comandos), la nueva versión queda reflejada sin intervención manual.
   - El archivo es **copia de consulta rápida** — nunca fuente de verdad.
10. **Revisión de Trabajo (`work_review.md`)**: Ejecutar el protocolo de revisión de `overview/work/` respetando prioridades (1º `tasks.md`, 2º `pendientes.md`, 3º `deuda_tecnica.md`) según `templates/work_review.md`.
11. Reportar en 5 líneas máximo: agente anterior, nodo activo, tareas pendientes, estado validación, flags (alias/session/líneas/conflicto), síntesis de `work_review` y próximo paso.

---

### `$status`

Mostrar el estado actual del proyecto sin modificar ningún archivo.

El agente debe leer y reportar en formato compacto:
```
Agente activo : [firma]
Nodo activo   : [id de progress.md]
Validación    : [verificado | no verificado | no aplica]
Tareas abiertas: [IDs y resumen de work.md con estado ≠ hecho]
Próximo paso  : [## Reanudar de session.md]
```

---

### `$work [descripción]`

Registrar una nueva tarea o bug en el sistema de trabajo modular `overview/work/`.

El agente debe:
1. Determinar tipo: `tarea` (mejora/feature), `bug` (comportamiento inesperado) o `deuda`.
2. Generar el próximo ID correlativo (ej. `w4` si el último es `w3`).
3. Registrar en `overview/work/tasks.md`: indicar la tarea a iniciar, clasificarla (`problema`, `mejora`, `refactor`) y redactar hipótesis/soluciones planteadas.
4. Agregar fila en el índice maestro `overview/work.md` con el ID, tipo y estado `pendiente`.
5. **Sincronización Automática y Mapeo Incremental**: Actualizar automáticamente de forma simultánea todos los archivos de control en `overview/` (`pendientes.md`, `deuda_tecnica.md`, `tasks.md`, `session.md`, `work_review.md`, `work.md` y `architecture.md`), mapeando únicamente los nodos (pantallas, clases, providers, repos) que la tarea concretamente va a tocar (sin sweep completo del repo) y sin requerir recordatorio manual del usuario.
6. Si es un bug: agregar entrada vacía en `## 📋 Historial de Intentos` en `work.md` con header `### [ID] [descripción]`.
7. Confirmar: `Registrado como [ID] en work.md, mapeado en architecture.md y sincronizado automáticamente en overview/ (tasks, session, pendientes, deuda).`

Ejemplo de uso:
```
$work bug: el drawer no cierra al navegar con GoRouter en iOS
```

---

### `$archi`

Protocolo dedicado exclusivamente a garantizar la **exhaustividad total** de la arquitectura viva. Su única tarea es auditar y registrar hasta el último rincón del proyecto (pantallas, widgets, servicios, providers, repositorios y modelos) en `overview/architecture.md`.

El agente debe:
1. Escanear exhaustivamente la estructura completa del proyecto y las modificaciones/conexiones no mapeadas previamente.
2. Leer `overview/architecture.md`.
3. Actualizar `overview/architecture.md` incorporando o completando los **diagramas sintéticos Mermaid** (`graph LR` / `graph TD`) y las tablas de mapa de conexiones clave hasta lograr cobertura del 100%. **Omitir bloques de texto redundantes**; toda la estructura y sus conexiones deben expresarse de forma sintética mediante diagramas.
4. Confirmar: `Arquitectura viva registrada exhaustivamente en overview/architecture.md con cobertura total y diagramas Mermaid.`

Ejemplo de uso:
```
$archi
```

---

### `$learn [texto]`

Registrar un aprendizaje general candidato en `overview/learning.md`.

El agente debe:
1. Validar el texto con el **Filtro Agnóstico** (`brain.md`): rechazar código específico, snippets de UI o comandos CLI rígidos. Si contiene código o comandos, abstraer a regla o proceso de diagnóstico agnóstico.
2. Agregar bajo `## 📌 Propuestas de mejora` en `overview/learning.md` un bullet sin etiqueta de skill.
3. Si el archivo no existe, crearlo desde `templates/learning.md`.
4. **NUNCA** modificar `.agents/` ni `.skill/`. Solo registrar en `overview/`.
5. Confirmar: `Aprendizaje registrado en overview/learning.md.`

> Ver protocolo completo en `core/learning_protocol.md`.

Ejemplo de uso:
```
$learn Siempre inicializar GoRouter fuera del widget tree para evitar rebuilds
```

---

### `$learnskill [nombre-skill] [texto]`

Registrar una propuesta de mejora específica para una skill instalada en `.skill/`, **sin tocarla directamente**.

El agente debe:
1. Identificar el nombre de la skill (ej: `i18n-agent-skill`, `monitoring-agent-skill`).
2. Agregar en `overview/learning.md` bajo `## 📌 Propuestas de mejora` con la **convención de etiqueta**:
   ```
   - [nombre-skill] descripción de la propuesta...
   ```
3. **NUNCA** modificar `.skill/[nombre-skill]/` directamente.
4. Confirmar: `Propuesta para [nombre-skill] registrada en overview/learning.md.`

Ejemplo:
```
$learnskill i18n-agent-skill Agregar soporte para idioma PT-BR en la cascada de fallback
```

---

### `$revlearnskill`

Revisar y clasificar las propuestas de skills dentro de `overview/learning.md` del governing repo. **Ejecutar SOLO en el repositorio oficial de gobernanza** (`*-agent-rules`) durante el `$boot` del Core.

**Todo el resultado queda en `overview/learning.md`. El agente no modifica ningún otro repositorio ni submódulo.**

El agente debe:
1. Leer `overview/learning.md` del governing repo.
2. Para cada bullet `- [nombre-skill]` en `## 📌 Propuestas de mejora`:
   - ✅ **Aplicada**: Mover a `## 📜 Histórico de mejoras aplicadas` con fecha.
   - ❌ **Rechazada**: Eliminar con nota de razón (viola Filtro Agnóstico o no aplica).
   - ⏳ **Pendiente**: Conservar para la siguiente revisión.
3. Confirmar: `$revlearnskill completado. [N] aplicadas al Histórico, [N] pendientes, [N] rechazadas.`

> La incorporación física de una mejora al repo canónico de la skill la realiza el **mantenedor** — no el agente desde el proyecto.
> Ver protocolo completo en `core/learning_protocol.md`.

---

### `$learnagnostico [texto]`

Abstraer un aprendizaje candidato descontextualizando el proyecto antes de registrar.

El agente debe:
1. Sustituir nombres propios de app/módulo/ruta y términos específicos de negocio (ej. joyas, mascotas, inventarios) por términos genéricos de arquitectura agnósticos (entidad, procesamiento, capa, destino, persistencia, navegación, etc.).
2. Eliminar IDs de negocio, pantallas concretas y paths de proyecto.
3. Aplicar **Filtro Agnóstico** (`brain.md`) al texto resultante.
4. Registrar el bullet abstraído en `overview/learning.md` bajo `## 📌 Propuestas de mejora` (crear desde plantilla si falta).
5. Confirmar: `Aprendizaje agnóstico registrado.` + mostrar una línea con el texto final.

Ejemplo:
```
$learnagnostico En MóduloX el flujo Entrada→Inventario→Salida debe documentarse aparte de architecture
```
→ bullet: `Documentar flujos de dominio (origen → procesamiento → destino) en overview/workflows/, no en architecture.md.`

---

### `$close`

Protocolo de cierre de sesión. Es **regla obligatoria** la **sincronización automática y simultánea** de todos los archivos de control en `overview/` (`pendientes.md`, `deuda_tecnica.md`, `tasks.md`, `session.md`, `work_review.md`, `work.md` y `architecture.md`) sin requerir recordatorio manual por parte del usuario.

El agente debe:
1. Ejecutar `flutter analyze` si aplica. Suite de tests: ausente (sin carpeta `test/`) → `no aplica`; presente y no corrida/fallida → `no verificado` + motivo. Si la tarea implica build o release → consultar `.agents/knowledge/release_checklist.md`.
2. Registrar ítems o tareas secundarias identificadas durante la ejecución en `overview/work/pendientes.md`.
3. Actualizar índice maestro `overview/work.md` con cambios de la sesión, retirar cualquier ítem/deuda resuelta inmediatamente de las tablas activas y trasladarlo a `## ✅ Completados (Historial)` en `work.md`, `deuda_tecnica.md` y `pendientes.md` conservando su ID.
4. Sincronizar simultáneamente todos los archivos de control en `overview/` (`session.md`, `work.md`, `tasks.md`, `pendientes.md`, `deuda_tecnica.md`, `work_review.md` y `architecture.md`).
5. Actualizar `overview/session.md`:
   - Registrar `Agente:` con firma propia.
   - Completar `## Cambios` con lo trabajado.
   - Completar `## Reanudar` con el siguiente nodo y contexto crítico.
6. Actualizar `overview/trackers/progress.md`.
7. Si hay sesiones antiguas irrelevantes → archivar en `overview/history/`.
8. Si hay mejora candidata identificada → agregar a `overview/learning.md`.
9. Reportar: `Sesión cerrada con sincronización automática de rastreadores. Próximo: [nodo]. Estado: [verificado/no verificado/no aplica].`

---

## Reglas de parsing

- El prefijo `$` debe ser el **primer carácter** del mensaje o estar en línea propia para ser reconocido como comando.
- Si el `$`-comando va acompañado de texto adicional (ej. `$learn texto aquí`), el texto después del comando es el argumento.
- Si el argumento falta donde es requerido, el agente debe pedirlo en una sola línea.
- Los comandos son **case-insensitive**: `$Boot`, `$BOOT` y `$boot` son equivalentes.
- Si el agente no reconoce el comando, responder: `Comando desconocido. Disponibles: $boot $status $work $archi $learn $learnagnostico $learnskill $revlearnskill $close`.
