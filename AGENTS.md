# PLATE Coaching

## Project structure

- `lib/app/` contains the theme, screen registry, and centralized named-route configuration.
- `lib/screens/8a/` and `lib/screens/1d/` through `lib/screens/10d/` contain one Dart screen per folder.
- `lib/widgets/` contains reusable phone frames, navigation, cards, buttons, avatars, and status labels.
- `lib/state/` contains the app-wide `ChangeNotifier` and its inherited scope for local mock coaching data.
- `test/` contains Flutter widget tests.
- `plate-all.html` is the visual reference; leave it unchanged.

## Rules

- Implement only customer coaching screen 8A and online coaching screens 1D–10D. Do not add gym, bar, or admin screens.
- Keep each screen's layout and interactions in its own folder. Put reusable UI in `lib/widgets/` and shared mock state in `lib/state/`.
- Register screens and route paths in `lib/app/screen_registry.dart` and `lib/app/app_routes.dart`; paths use the screen ID (for example, `/6D`).
- Preserve the reference design language: pale teal background, white cards, coral accent, rounded surfaces, and compact mobile layouts.
- Keep interactions client-side and provide clear feedback when using mock data.
- Use Flutter and Dart only. Run `flutter analyze` after code changes.
