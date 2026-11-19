# 🧩 Patrones Transversales de Diseño y Modularidad

> **Ámbito de Aplicación**: Estándar agnóstico heredado de `agent-rules-ecosystem/ARCHITECTURE_STANDARD.md`. Aplica a cualquier módulo o refactorización, independientemente del lenguaje o framework.

1. **Modularización Segura con Re-exportación Retrocompatible (`<250L`)**:
   - Al dividir archivos monolíticos (`>250L`), transformar el archivo maestro en un *barrel export* (o fachada) que re-exporte los submódulos extraídos, preservando los contratos de importación sin refactors en cascada. Validar atómicamente con análisis estático antes de avanzar.
2. **Principio de Parquedad en Gestión de Estado**:
   - Antes de reportar como deuda técnica la ausencia de gestores de estado complejos, verificar si los mecanismos reactivos nativos del entorno resuelven el flujo con claridad y sin sobreingeniería.
3. **Inicialización Perezosa (*Lazy Loading*) en Navegación y Módulos**:
   - Evitar la instanciación prematura de todos los sub-árboles o módulos en contenedores de navegación/rutas; cargar bajo demanda según el contexto activo para reducir consumo de memoria y tiempo de arranque.
4. **Encapsulación CRUD Genérica**:
   - Cuando existan múltiples entidades de dominio con operaciones equivalentes, encapsular los verbos CRUD en adaptadores o controladores genéricos parametrizados para eliminar boilerplate y divergencias.
5. **Unificación de Procesos Hermanos/Paralelos**:
   - Unificar la lógica de mutación de procesos que operan sobre estructuras de datos simétricas mediante funciones puras o de orden superior compartidas para garantizar paridad.
6. **Descomposición Funcional en Generadores de Salida Densa**:
   - En generadores de documentos o reportes complejos, aislar la construcción de cada bloque funcional en helpers privados puros para facilitar el mantenimiento de layout sin alterar la estructura global.
7. **Filtrado por Relación Directa de Dominio**:
   - En flujos de entrada dependientes, filtrar opciones válidas mediante relaciones directas entre entidades de dominio en lugar de usar diccionarios de sinónimos o fallbacks estáticos.
8. **Sincronización Reactiva Inmediata en Estado Derivado**:
   - En rankings, métricas o vistas agregadas, propagar de inmediato reversiones y reinicios tanto en memoria como en persistencia para evitar desfasajes en tiempo real.
9. **Normalización y Auto-reparación de Datos Persistentes**:
   - Al clasificar entidades persistentes en categorías disjuntas, aplicar normalizadores basados en metadatos y auto-reparar retroactivamente registros legados al inicializar.
10. **Principio Contract-First (Prohibición de Invención Unilateral)**:
    - En cualquier frontera productor/consumidor (APIs, eventos, FFI), prohibir asumir, omitir o alterar campos, firmas o códigos de error sin actualizar previamente el contrato compartido.
