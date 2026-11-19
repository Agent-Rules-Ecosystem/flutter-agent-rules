# Estructura Estándar de Proyecto Flutter

Este documento especifica la estructura de carpetas y archivos nativos estándar reconocidos en un proyecto Flutter. Durante el protocolo de discovery, cualquier carpeta raíz fuera de esta lista es identificada como **no-estándar** y debe ser procesada mediante inspección semántica recursiva para relocalizar su contenido en `overview/`.

## Directorios Estándar del Framework Flutter

| Directorio | Propósito | Tratamiento |
|---|---|---|
| `lib/` | Código fuente Dart principal de la app | Conservar en root |
| `android/` | Proyecto y artefactos nativos Android | Conservar en root |
| `ios/` | Proyecto y artefactos nativos iOS | Conservar en root |
| `web/` | Código y plantilla nativa Web | Conservar en root |
| `windows/` | Runner y configuración nativa Windows | Conservar en root |
| `linux/` | Runner y configuración nativa Linux | Conservar en root |
| `macos/` | Runner y configuración nativa macOS | Conservar en root |
| `test/` | Pruebas unitarias y de widgets | Conservar en root |
| `integration_test/` | Pruebas de integración end-to-end | Conservar en root |
| `assets/` | Recursos estáticos (imágenes, fuentes, json) | Conservar en root |
| `build/` | Salida de compilación (artefactos temporales) | Ignorar en discovery |
| `.dart_tool/` | Metadata del SDK de Dart/Flutter | Ignorar en discovery |
| `.idea/` | Configuración IDE IntelliJ / Android Studio | Ignorar en discovery |
| `.vscode/` | Configuración IDE Visual Studio Code | Ignorar en discovery |
| `.git/` | Repositorio y metadata Git | Ignorar en discovery |
| `.agents/` | Submódulo oficial de reglas compartidas | Conservar en root |
| `.skill/` | Submódulos de skills independientes del proyecto | Conservar en root |
| `overview/` | Estado local versionado del proyecto | Conservar en root |

## Archivos Estándar en Root

- `pubspec.yaml`, `pubspec.lock`
- `analysis_options.yaml`
- `README.md`, `CHANGELOG.md`, `LICENSE`
- `.gitignore`, `.metadata`

## Regla de Inspección para Carpetas No-Estándar

Cualquier otro directorio o subdirectorio anidado hallado en el root (ejemplo: `docs/`, `legacy/`, `notes/`, `cosas/`, `trackers/`, etc.) **no pertenece a la estructura estándar de Flutter**.

1. Recorrer de manera recursiva todas sus subcarpetas y archivos.
2. Aplicar la tabla de clasificación semántica definida en `core/brain.md`.
3. Relocalizar o consolidar su contenido en `overview/`, `overview/context/`, `overview/trackers/` u `overview/history/`.
4. Garantizar cero archivos huérfanos sin eliminar código ni artefactos pertenecientes al desarrollo nativo de Flutter.
