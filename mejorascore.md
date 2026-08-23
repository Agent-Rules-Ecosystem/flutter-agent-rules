# 🚀 Plan de Mejoras y Hoja de Ruta — Flutter Agent Rules & Skills

> **Repositorio Oficial**: [Agent-Rules-Ecosystem/flutter-agent-rules](https://github.com/Agent-Rules-Ecosystem/flutter-agent-rules)  
> **Evaluación Global del Sistema**: **9.2 / 10** *(Enterprise Grade / Context Engineering Architecture)*  
> Documento de evolución del sistema de gobernanza y habilidades para agentes de IA en Flutter. Organizado estrictamente por **orden de factibilidad y facilidad de realización**.

---

## 📌 Fase 1: Publicación Open Source y Documentación (Inmediata / Esfuerzo Bajo)

*Prioridad: Alta | Factibilidad: 100% Inmediata*

* [x] **Publicación en GitHub**: Hospedado en la organización oficial [`Agent-Rules-Ecosystem/flutter-agent-rules`](https://github.com/Agent-Rules-Ecosystem/flutter-agent-rules).

* [ ] **Quickstart Guide (`QUICKSTART.md`)**:
  * Crear una guía de integración de 1 minuto explicando cómo añadir `.agents/` y `.skill/` en un proyecto Flutter nuevo o existente en 3 comandos CLI.
* [ ] **Configuración de Plantilla de GitHub (Template Repository)**:
  * Habilitar el repositorio `flutter-agent-rules` y la especificación `SKILL_STANDARD` como plantillas oficiales en GitHub.
* [ ] **Licenciamiento Abierto**:
  * Asegurar la inclusión de la licencia MIT o Apache 2.0 para habilitar la adopción en la comunidad de desarrolladores y empresas.
* [ ] **Limpieza de Datos de Privacidad y Auditoría Pre-Publicación**:
  * Verificar que todos los ejemplos y plantillas en `templates/` estén 100% desprovistos de credenciales, tokens o referencias de dominio privado.

---

## 📌 Fase 2: Herramientas de Validación de Calidad / Agent Linter (Corto Plazo / Esfuerzo Medio)

*Prioridad: Alta | Factibilidad: Alta*

* [ ] **Script de Salud del Estado del Agente (`agent_health`)**:
  * Desarrollar un script automatizado (Bash o Dart) que verifique la integridad del proyecto antes de un commit o durante `$boot`.
* [ ] **Verificador de Consistencia de `overview/`**:
  * Validar que los 7 rastreadores de `overview/` (`session.md`, `work.md`, `architecture.md`, `tasks.md`, `pendientes.md`, `deuda_tecnica.md`, `learning.md`) existan, mantengan el formato esperado y no tengan secciones corruptas.
* [ ] **Validador de Sintaxis Mermaid sintética**:
  * Analizar automáticamente que los diagramas Mermaid generados durante `$archi` no contengan errores de sintaxis que rompan el renderizado.
* [ ] **Auditor del Estándar de Skills (`SKILL_STANDARD.md`)**:
  * Verificar que todos los submódulos dentro de `.skill/` cumplan con la estructura canónica (`adapters/`, `core/`, `knowledge/`, `resources/`, `scripts/`).

---

## 📌 Fase 3: Manifiesto y Grafo de Dependencias de Skills (Mediano Plazo / Esfuerzo Medio)

*Prioridad: Media | Factibilidad: Media-Alta*

* [ ] **Especificación de Manifiesto (`skill.yaml`)**:
  * Definir un esquema ligero de metadatos para cada skill (`name`, `version`, `author`, `dependencies`, `compatible_rules`).
* [ ] **Resolución de Dependencias entre Skills**:
  * Permitir que un skill declare requisitos previos (ejemplo: `flutter-firebase-auth-agent-skill` declare como dependencia a `flutter-bloc-patterns-agent-skill`).
* [ ] **Instalador Inteligente de Skills**:
  * Script CLI para clonar e inicializar un skill junto con todas sus dependencias con un solo comando (ej. `./scripts/install_skill.sh <url-del-skill>`).

---

## 📌 Fase 4: Integración Avanzada con Estándares de Industria / MCP (Largo Plazo / Esfuerzo Alto)

*Prioridad: Estratégica | Factibilidad: Progresiva*

* [ ] **Puente y Soporte para MCP (Model Context Protocol)**:
  * Diseñar un conector o servidor local MCP que exponga las reglas y scripts de diagnóstico como herramientas nativas consumibles por modelos compatibles (Anthropic, Claude Desktop, Cursor, etc.).
* [ ] **Métricas y Telemetría de Rendimiento de Agentes**:
  * Medir la tasa de éxito de tareas, ahorro estimado de tokens por sesión y fricción de contexto durante los ciclos de `$work` y `$close`.
* [ ] **Auto-Promoción de Aprendizajes de `overview/learning.md`**:
  * Mecanismo para automatizar la extracción de propuestas validadas en `learning.md` y generar Pull Requests hacia el repositorio central `flutter-agent-rules`.

---

## 📄 Anexo: Resumen de la Evaluación de Arquitectura

### Fortalezas Clave del Sistema Activo
1. **Máquina de Estados Finitos (`$-Comandos`)**: Transición clara entre `$boot`, `$work`, `$archi`, `$learn` y `$close`.
2. **Desacoplamiento Multi-Modelo**: Adaptadores específicos para Gemini, Claude, OpenAI y Cursor sin perder la historia ni el contexto.
3. **Modo Cavernícola y Token Optimization**: Ahorro drástico de presupuesto de tokens mediante referencias por rango de líneas y resúmenes Mermaid.
4. **Filtro Agnóstico**: Inviolabilidad de `.agents/` para garantizar que la gobernanza siga siendo reutilizable y universal.
