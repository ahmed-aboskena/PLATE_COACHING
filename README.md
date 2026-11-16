# PLATE Coaching

A Flutter coaching app based on the supplied `plate-all.html` visual reference.
It includes customer screen 8A and online coaching screens 1D–10D, with local
mock data for booking, messaging, client plans, calls, and coach availability.

## Run

```shell
flutter pub get
flutter run
```

## Verify

```shell
flutter analyze
flutter test
```

The app opens on the member's online training screen. Coaching screens use
their reference IDs as named routes (for example, `/6D`) and can be reached
through the in-app navigation. See [AGENTS.md](AGENTS.md) for structure and
contribution rules.
