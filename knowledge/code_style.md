# Estilo Flutter / Dart

## Widgets y archivos

- Usar `const` cuando aplique.
- Mantener archivos Dart idealmente bajo 250 líneas; máximo 300.
- Extraer widgets o diálogos extensos de pantallas principales.
- Liberar `TextEditingController`, `AnimationController` y `StreamSubscription`.
- Centralizar estado con patrón elegido por proyecto. Si usa Riverpod, separar vista de providers/notifiers.
- En `DropdownButtonFormField`, usar `initialValue`; evitar `value` deprecado.

## Nombrado

| Elemento | Convención | Ejemplo |
|---|---|---|
| Clases / Widgets | `PascalCase` | `UserProfileCard` |
| Archivos Dart | `snake_case` | `user_profile_card.dart` |
| Variables / métodos | `camelCase` | `fetchUserData()` |
| Constantes | `camelCase` con `const` | `const defaultTimeout` |
| Providers (Riverpod) | `camelCaseProvider` | `authStateProvider` |
| Enums | `PascalCase`, valores `camelCase` | `enum Status { loading, done }` |

- Nombres descriptivos. Evitar: `data`, `info`, `temp`, `val` sin contexto.
- Prefijo `_` solo para privados de clase, no para variables locales.

## Async / Await

- Preferir `async`/`await` sobre `.then()` encadenado para legibilidad.
- Usar `FutureBuilder` solo cuando el `Future` sea local al build. Para estado global → provider/notifier.
- No usar `await` en `initState`; usar `Future.microtask(() => ...)` o manejar en el provider.
- Siempre manejar el caso `AsyncError` en `FutureBuilder` / `AsyncValue`.

## Manejo de errores

- Nunca silenciar errores con `catch (e) {}` vacío. Mínimo: loguear con `debugPrint`.
- Usar tipos de error específicos del dominio; evitar `Exception` genérica en lógica de negocio.
- En UI: mostrar `SnackBar` o diálogo — nunca dejar error silencioso al usuario.
- Separar errores de red, de validación y de negocio en capas distintas.

## Navegación

- Usar el sistema de rutas del proyecto (GoRouter / Navigator 2 / Navigator 1 — según proyecto).
- No mezclar estilos de navegación en el mismo proyecto.
- Pasar solo datos serializables por rutas nominadas. Objetos complejos → provider compartido.
- `context.pop()` con resultado en diálogos/sheets; no usar `Navigator.of(context).pop()` directamente si el proyecto usa GoRouter.

## Nulabilidad

- Usar sound null-safety (estándar en Dart 3+). No usar `!` sin garantía explícita de no-nulidad.
- Preferir `??` y `?.` sobre comprobaciones `if (x != null)` verbosas.
- Evitar `late` salvo en campos inicializados en `initState` con justificación clara.
