# 🚀 Plan de Mejoras y Hoja de Ruta — Flutter Agent Rules & Skills

> **Repositorio Oficial**: [Agent-Rules-Ecosystem/flutter-agent-rules](https://github.com/Agent-Rules-Ecosystem/flutter-agent-rules)  
> **Evaluación Global del Sistema**: **9.2 / 10** *(Enterprise Grade / Context Engineering Architecture)*  
> Documento de evolución del sistema de gobernanza y habilidades para agentes de IA en Flutter. Organizado estrictamente por **orden de factibilidad y facilidad de realización**.

---

## 📌 Fase 1: Publicación Open Source y Documentación (Inmediata / Esfuerzo Bajo)

*Prioridad: Alta | Factibilidad: 100% Inmediata*

* [x] **Publicación en GitHub**: Hospedado en la organización oficial [`Agent-Rules-Ecosystem/flutter-agent-rules`](https://github.com/Agent-Rules-Ecosystem/flutter-agent-rules).

* [x] **Quickstart Guide destacada en `README.md`**:
  * Guía de integración de 1 minuto agregada al inicio del README explicando cómo añadir `.agents/` y los adaptadores en 3 comandos CLI.
* [x] **Configuración de Plantilla Canónica de GitHub**:
  * Configurado [`agent-rules-ecosystem`](https://github.com/Agent-Rules-Ecosystem/agent-rules-ecosystem) como **Template Repository** oficial para crear nuevas variantes de reglas por lenguaje/framework.
  * `flutter-agent-rules` se mantiene como repositorio de gobernanza activo para ser consumido directamente como submódulo de Git (`.agents/`).
* [x] **Licenciamiento Abierto (MIT License)**:
  * El repositorio cuenta con el archivo oficial [`LICENSE`](https://github.com/Agent-Rules-Ecosystem/flutter-agent-rules/blob/main/LICENSE) bajo la **Licencia MIT**, habilitando el uso libre, comercial y de modificación por la comunidad.
* [x] **Limpieza de Datos de Privacidad y Auditoría Pre-Publicación**:
  * Verificar que todos los ejemplos y plantillas en `templates/` estén 100% desprovistos de credenciales, tokens o referencias de dominio privado.

---

## 📌 Fase 2: Herramientas de Validación de Calidad / Agent Linter (Corto Plazo / Esfuerzo Medio)

*Prioridad: Alta | Factibilidad: Alta*

* [x] **Plantilla de Salud del Estado del Agente (`agent_health.md`)**:
  * Definida la plantilla declarativa Markdown (`scripts/agent_health.md`) para auditar la integridad del proyecto antes de un commit o durante `$boot`.
* [x] **Verificador de Consistencia de `overview/`**:
  * Protocolo declarativo para validar que los rastreadores de `overview/` (`session.md`, `work.md`, `architecture.md`, `tasks.md`, `pendientes.md`, `deuda_tecnica.md`, `learning.md`, `work_review.md`) existan y no estén corruptos o vacíos.
* [x] **Validador de Sintaxis Mermaid sintética**:
  * Guía declarativa para analizar que los diagramas Mermaid no contengan errores de sintaxis (como paréntesis no entrecomillados dentro de etiquetas).
* [x] **Auditor del Estándar de Skills (`SKILL_STANDARD.md`)**:
  * Matriz declarativa para verificar que todos los submódulos dentro de `.skill/` o `skills/` cumplan con la estructura canónica (`SKILL.md`, `adapters/`, etc.).

---

## 📌 Fase 3: Manifiesto y Grafo de Dependencias de Skills (Mediano Plazo / Esfuerzo Medio)

*Prioridad: Media | Factibilidad: Media-Alta*

* [x] **Especificación de Manifiesto (`skill.md`)**:
  * Esquema ligero de metadatos 100% Markdown (`name`, `version`, `description`, `author`, `compatible_rules`, `dependencies`) integrado en `skill.md` en las 12 habilidades del ecosistema.
* [x] **Resolución de Dependencias entre Skills**:
  * Declaración y resolución lógica de requisitos previos (ejemplo: `flutter-firebase-auth-agent-skill` y `flutter-firebase-odoo-agent-skill` requieren `flutter-bloc-patterns-agent-skill`).
* [x] **Instalador Inteligente de Skills (`install_skill.md`)**:
  * Guía declarativa en formato Markdown (`scripts/install_skill.md`) para inicializar una habilidad como submódulo junto con todas sus dependencias recursivas.

---

## 📌 Fase 4: Integración Avanzada con Estándares de Industria / MCP (Largo Plazo / Esfuerzo Alto)

*Prioridad: Estratégica | Factibilidad: Progresiva*

* [x] **Puente y Soporte para MCP (Model Context Protocol)**:
  * Especificación declarativa en Markdown (`scripts/mcp_server.md`) que define el conector local JSON-RPC/MCP para exponer herramientas de diagnóstico a modelos compatibles (Anthropic, Claude Desktop, Cursor, OpenAI, etc.).
* [x] **Métricas y Telemetría de Rendimiento de Agentes**:
  * Plantilla declarativa (`scripts/agent_telemetry.md`) para registrar métricas de resolución de tareas, deuda técnica e histórico en formato Markdown.
* [x] **Auto-Promoción de Aprendizajes de `overview/learning.md`**:
  * Especificación declarativa (`scripts/promote_learning.md`) para la extracción y propuesta de reglas hacia la gobernanza central.

---

## 📄 Anexo: Resumen de la Evaluación de Arquitectura

### Fortalezas Clave del Sistema Activo
1. **Máquina de Estados Finitos (`$-Comandos`)**: Transición clara entre `$boot`, `$work`, `$archi`, `$learn` y `$close`.
2. **Desacoplamiento Multi-Modelo**: Adaptadores específicos para Gemini, Claude, OpenAI y Cursor sin perder la historia ni el contexto.
3. **Modo Cavernícola y Token Optimization**: Ahorro drástico de presupuesto de tokens mediante referencias por rango de líneas y resúmenes Mermaid.
4. **Filtro Agnóstico**: Inviolabilidad de `.agents/` para garantizar que la gobernanza siga siendo reutilizable y universal.
