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
| `$archi` | Actualizar arquitectura viva conforme a ARCHITECTURE_STANDARD.md |
| `$learn [texto]` | Registrar aprendizaje general candidato en `overview/learning.md` |
| `$learnagnostico [texto]` | Abstraer a términos genéricos antes de registrar |
| `$learnskill [skill] [texto]` | Registrar propuesta de mejora para una skill en `overview/learning.md` |
| `$revlearnskill` | Clasificar propuestas `[nombre-skill]` en el governing repo (`*-agent-rules`) |
| `$laconico` | Activar o reforzar el Modo Lacónico (por defecto) |
| `$modo:detallado` | Activar explicaciones técnicas paso a paso sin relleno |
| `$close` | Protocolo de cierre de sesión con sincronización automática de rastreadores |


---

## Definición de cada comando

### `$boot`

Dispara el bootstrap completo. Equivalente a **"ejecuta .agents"** pero más corto.

Pasos que el agente debe ejecutar:
0. Verificar que exista `.git/` (en proyectos limpios o ZIP sin control de versiones, ejecutar `git init` antes de intentar vincular submódulos `.agents` o `.skill/*`) y correr `git submodule status` para verificar integridad de submódulos.
1. Leer `core/path_map.md`, `core/communication.md`, `core/brain.md`, `core/commands.md`.
2. **Scaffold incremental desde templates**: Comparar la estructura de `templates/` con `overview/`. Por cada archivo o subdirectorio presente en `templates/` que no exista en `overview/`, crearlo copiando el contenido de la plantilla correspondiente. Este paso aplica tanto a proyectos nuevos (sin `overview/`) como a proyectos existentes donde el ecosistema ha evolucionado y agregado nuevas estructuras canónicas. **No sobreescribir** archivos que ya existan en `overview/`. **Excepciones**: (a) archivos de ejemplo/placeholder (`architecture/modules/principal.md`, `workflows/flujo_ejemplo.md`, `sesion_YYYY-MM-DD.md`, `contexto_dominio.md`) solo se copian si el subdirectorio destino está vacío o ausente; (b) no recrear `modules/<x>.md` si ya existe su carpeta atómica `modules/<x>/`; (c) excluir plantillas cuyo destino no es `overview/` (ver `core/path_map.md`).
3. Cargar archivos de control según el **Protocolo de Carga de Contexto en 3 Capas** (`core/brain.md`): primero **Capa 1** (`overview/session.md`, `overview/work.md`), y cargar **Capa 2** (`tasks.md`, `pendientes.md`, `deuda_tecnica.md`) en el Paso 10 (`work_review.md`) o bajo demanda por categoría.
4. Evaluar `Agente:` y `Modo:` en `overview/session.md`: si `Agente:` difiere del modelo actual → activar protocolo `## Handoff de Agente` de `brain.md`. El modo por defecto es `laconico` (solo cambiar a `detallado` si `Modo: detallado` está explícito en `session.md`). Si `session.md` es legado (faltan `Agente:`, `Modo:`, `## Reanudar` o `## Cambios`) → reportar `session legado`; única edición automática permitida: añadir `Modo: laconico` si solo falta ese campo. Alias (`tasks.md`/`tracker.md`) que sean stubs de redirección no generan `[consolidar alias]`.
5. Alias divergentes: si alias y canónico coexisten con contenido distinto (`tasks.md`/`work.md`, `tracker.md`/`trackers/progress.md`) → flag `[consolidar alias]` en `work.md`. No marcar si uno de los dos es un stub de redirección (contiene solo una nota `Alias consolidado` y un enlace al canónico).
6. `session.md` legado: si faltan `Agente:`, `Modo:`, `## Reanudar` o `## Cambios` → reportar `session legado`. Única edición automática permitida: añadir `Modo: laconico` si solo falta ese campo; el resto se migra solo con confirmación.
7. Auditoría de líneas: listar archivos de código fuente >250L; en monorepos o bundles multi-app, filtrar y agrupar por módulo de negocio antes de sugerir IDs `deuda` en `overview/work/deuda_tecnica.md` (prioridades **Alta**, **Media**, **Baja**). Excluir autogenerados y artefactos: `build/`, `dist/`, `generated/`, `l10n/generated/`, `*.g.dart`, `*.freezed.dart`, bundles (`bundle.js`, `*.min.*`), lockfiles y dumps de datos; separar tests/HTML/CSS de los módulos fuente.
8. Auditar `overview/learning.md` (Protocolo de 3 Vías — ver `core/learning_protocol.md`): por cada bullet en `## 📌 Propuestas de mejora` evaluar si está ✅ aplicada (promover al `## 📜 Histórico`), ❌ rechazada (viola Filtro Agnóstico → eliminar), ⚠️ en conflicto con regla existente (flag `[conflicto learning: regla X]` en `work.md`) o ⏳ pendiente (conservar). Bullets con etiqueta `- [nombre-skill]` son propuestas para skills: ejecutar `$revlearnskill` en el governing repo cuando aplique.
9. **Verificación y actualización de `overview/commands_project.md`**: En cada `$boot`, el agente escanea los comandos del Core (`.agents/core/commands.md`) y de las skills instaladas (`.skill/*/core/commands.md`). Si el archivo no existe o si se detectan diferencias con su contenido actual (comandos agregados, modificados o eliminados), actualiza únicamente las secciones necesarias para reflejar el estado exacto del proyecto. Regenerar únicamente dentro de los bloques delimitados `<!-- CORE_START -->…<!-- CORE_END -->` y `<!-- SKILLS_START -->…<!-- SKILLS_END -->`; los comandos propios del proyecto (fuera de los bloques) se preservan.
10. **Revisión de Trabajo (`work_review.md`)**: Ejecutar los pasos de `.agents/templates/work_review.md` (protocolo) leyendo secuencialmente `tasks.md`, `pendientes.md` y `deuda_tecnica.md` solo para sintetizar (sin retenerlos juntos), y escribir el resultado en `overview/work_review.md` (reporte mutable).
11. Reportar en 5 líneas máximo: agente anterior, nodo activo, tareas pendientes, estado validación, flags (alias/session/líneas/conflicto/skills-pendientes), síntesis de `work_review` y próximo paso. Incluir línea `scaffold:` listando archivos/dirs creados desde templates (o `scaffold: ninguno` si `overview/` ya estaba al día). La línea `scaffold:` es adicional y no cuenta dentro del límite de 5.

---

### `$status`

Mostrar el estado actual del proyecto sin modificar ningún archivo.

El agente debe leer y reportar en formato compacto:
```
Agente activo : [firma]
Nodo activo   : [id de progress.md]
Validación    : [verificado | no verificado | no aplica]
Tareas abiertas: [IDs y resumen de work.md con estado ≠ superseded]
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
7. **Feature-Stream / Code-to-Spec Hook**: Si el proyecto mantiene especificaciones o contratos (`specs/`, `overview/architecture/core/contracts.md`), propagar los cambios funcionales o de interfaz a la spec/contrato en el mismo ciclo para evitar deriva documental.
8. **Traslado físico al resolver**: Al resolver un ítem proveniente de `pendientes.md` o `deuda_tecnica.md` durante `$work`, mover físicamente su fila a `## ✅ Completados (Historial)` y actualizar `work.md`, retirándola de la tabla activa.
9. Confirmar: `Registrado como [ID] en work.md, mapeado en architecture.md y sincronizado automáticamente en overview/ (tasks, session, pendientes, deuda).`
10. **Ejecución continua**: El registro preventivo en `$work` es una salvaguarda anti-desconexión; el agente debe continuar de inmediato con la ejecución técnica de la tarea en el mismo turno sin detenerse.

Ejemplo de uso:
```
$work bug: el drawer no cierra al navegar con GoRouter en iOS
```

---

### `$archi`

Protocolo dedicado exclusivamente a auditar, modularizar y mantener la arquitectura del proyecto conforme al **Agent Architecture Standard (`ARCHITECTURE_STANDARD.md`)**.

El agente debe:
0. **Detección de archivo plano legado**: Si existe `overview/architecture.md` como archivo único (no carpeta), leerlo íntegramente como fuente de referencia. Usarlo para extraer diagramas, capas y módulos ya documentados antes de generar los subdocumentos. **No eliminarlo** hasta que la migración esté verificada.
1. Escanear exhaustivamente la estructura completa del proyecto, módulos y rutas.
2. Mantener `overview/architecture.md` como **Índice Raíz Hub & Spoke** (< 200L): diagrama Mermaid de alto nivel de capas, tabla de capas del sistema e hipervínculos a los subdocumentos en `overview/architecture/`. Si proviene de migración del archivo plano legado, extraer solo el contenido de alto nivel y mover los detalles técnicos a los subdocumentos.
3. Crear o actualizar los subdocumentos en `overview/architecture/` extrayendo o refinando el contenido del archivo plano legado (si existía):
   - `overview/architecture/routes_map.md` (Mapa global de enrutamiento y GoRouter).
   - `overview/architecture/core/data_flow.md` (Estado global, Riverpod/Hive, sync y persistencia).
   - `overview/architecture/core/import_rules.md` (Reglas de importación por nivel de capa).
   - `overview/architecture/modules/<modulo>.md` (Subdocumento por cada módulo que supere 2 diagramas Mermaid o 5 pantallas/componentes).
4. **Auditoría de Regla Atómica de Escala**: Por cada `overview/architecture/modules/<modulo>.md` existente, verificar si cubre más de un dominio de decisión (señal: el agente necesita leerlo completo para responder algo específico). Si se detecta, convertirlo en carpeta `overview/architecture/modules/<modulo>/` aplicando la Plantilla Canónica 3 de `ARCHITECTURE_STANDARD.md`: crear `<modulo>.md` como índice (< 150L) y subdocumentos atómicos por cada dominio identificado. **No anticipar subdivisiones futuras**: solo actuar cuando la señal es evidente en el módulo actual.
5. Confirmar: `Arquitectura viva actualizada conforme a ARCHITECTURE_STANDARD.md (Índice Raíz overview/architecture.md + Subdocumentos en overview/architecture/).`

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

### `$learnskill [skill] [texto]`

Registrar una mejora candidata para una skill específica en `overview/learning.md` bajo `## 📌 Propuestas de mejora` con la etiqueta `[nombre-skill]`, aplicando el Filtro Agnóstico. **NUNCA** modificar `.skill/` ni `.agents/` directamente. Ver detalle en `core/learning_protocol.md`.

---

### `$revlearnskill`

En el repositorio oficial de una skill (o del ecosistema), auditar `overview/learning.md` buscando propuestas etiquetadas `[nombre-skill]`, evaluarlas con la Evaluación de 3 Vías (`core/learning_protocol.md`) y promover o descartar según corresponda.

---

### `$laconico`

Activa o refuerza el **Modo Lacónico** (estilo operativo por defecto en `core/communication.md`): respuestas breves, directas, sin prosa ni clichés, usando flechas (`A -> B`) y referencias `[archivo#L10-L15]`. Actualiza `Modo: laconico` en `overview/session.md`.

---

### `$modo:detallado`

Conmuta temporalmente a **Modo Detallado**: habilita explicaciones técnicas paso a paso cuando la complejidad lo requiera, manteniendo tono sobrio, analítico, cero clichés y cero adulación. Actualiza `Modo: detallado` en `overview/session.md`. Para volver al modo breve, ejecutar `$laconico`.

---

### `$close`

Protocolo de cierre de sesión. Es **regla obligatoria** la **sincronización automática y simultánea** de todos los archivos de control en `overview/` (`pendientes.md`, `deuda_tecnica.md`, `tasks.md`, `session.md`, `work_review.md`, `work.md` y `architecture.md`) sin requerir recordatorio manual por parte del usuario.

El agente debe:
1. Ejecutar `flutter analyze` si aplica. Suite de tests: ausente (sin carpeta `test/`) → `no aplica`; presente y no corrida/fallida → `no verificado` + motivo. Aplicar la misma regla a cualquier checklist o verificación contextual: registrar explícitamente como **omitidas** (con motivo) las comprobaciones no ejecutables, sin contarlas jamás como aprobadas. Si la tarea implica build o release → consultar `.agents/knowledge/release_checklist.md`.
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
- Si el agente no reconoce el comando, responder: `Comando desconocido. Disponibles: $boot $status $work $archi $learn $learnagnostico $learnskill $revlearnskill $laconico $modo:detallado $close`.
