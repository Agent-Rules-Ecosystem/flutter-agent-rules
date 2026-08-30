# 📏 Reglas de Importación por Nivel y Capa

> Pertenece a: `overview/architecture/core/import_rules.md`  
> Referenciado desde: [`ARCHITECTURE.md`](../../ARCHITECTURE.md)

## 1. Directivas de Importación de Capas

1. **Presentation**: Puede importar `Domain` y `Core`. **Nunca** importa directamente `Infrastructure`.
2. **Domain**: Pura. **No importa** ninguna otra capa (`Presentation`, `Infrastructure`, `Core`).
3. **Infrastructure**: Implementa contratos de `Domain`. Puede importar `Core`.
4. **Core**: Compartido y transversal. No importa `Presentation` ni `Infrastructure`.
