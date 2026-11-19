---
name: flutter-clean-arch
description: Rules for Flutter modularization, Clean Architecture, file line limits (<250 lines), and Riverpod state management.
---

# Flutter Clean Architecture & Refactoring Skill

## 1. Regla del Límite de Líneas (<250-300 líneas)
- Todo archivo `.dart` debe mantenerse idealmente por debajo de **250 líneas** (máximo absoluto 300).
- Si un archivo excede las 300 líneas:
  1. Extraer métodos `_buildX()` a componentes independientes `StatelessWidget`.
  2. Extraer formularios y diálogos a su propio archivo (ej. `x_dialog.dart` o `x_form.dart`).
  3. Extraer lógica de cálculos o formateadores a helpers estáticos (ej. `x_helpers.dart`).

## 2. Diálogos y Modales
- Nunca incluir diálogos inline extensos dentro de las pantallas principales (`Screen`).
- Usar un archivo de diálogos dedicado (ej. `feature_editable_dialogs.dart`).
- Si varios diálogos comparten estructura (confirmación, alertas), crear un helper interno `_showConfirmDialog`.

## 3. Interfaces Adaptativas y Compactas
- Para soporte de pantallas pequeñas (ej. dispositivos portátiles/industriales):
  - Detectar tamaño compacto via `MediaQuery.sizeOf(context)`.
  - Definir bandera `final isCompact = height < 700 || width < 380;`.
  - Ajustar padding, fuentes y disposición de botones según `isCompact`.

## 4. Manejo de Estado (Riverpod)
- Separar la vista (Widget) del controlador (Notifier/Notifier / AsyncNotifier).
- Prevenir lógica de negocio o llamados Firebase dentro de los métodos `build()` de los widgets.

## 5. Validación y Release
- Antes de cualquier build (APK/AAB/IPA), consultar `.agents/knowledge/release_checklist.md`.
- Nunca presentar un build como validado sin haber ejecutado `flutter analyze` limpio.
