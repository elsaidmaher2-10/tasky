# Tasky — App Documentation

This document illustrates the main points and structure of the Tasky Flutter app.

## Quick Start
- Install dependencies and run the app:

```bash
flutter pub get
flutter run -d <device>
```

- Run tests:

```bash
flutter test
```

## Project Overview
- Purpose: A task management app with add/view/edit tasks, user profile, and theming.
- Platforms: Android, iOS, Web, macOS, Windows, Linux (Flutter multi-platform project).

## High-level Structure
- `lib/` — main Flutter source.
  - `main.dart` — app entry point.
  - `core/` — shared components, constants, services, enums, and theme.
  - `Feature/` — feature folders for screens (AddTask, Home, Profile, Tasks, Welcome).
  - `model/` — data models (e.g. `task_model.dart`).

## Screens & Flows
- Welcome: onboarding / first-run screen.
- Home: dashboard showing summary and navigation to task lists.
- Tasks: full list of tasks, filters, and search.
- Add Task: form to create a new task with title, description, due date, priority, etc.
- Profile: user settings and account info.

Each screen typically lives under `Feature/<Name>/` with subfolders for widgets and controllers.

## Core Components
- UI components: reusable widgets in `lib/core/component/` (buttons, inputs, cards).
- Theme: centralized styles in `lib/core/theme/` (colors, text styles, theme toggles).
- Constants & Enums: `lib/core/constant/` and `lib/core/enum/` for shared values.

## Data Model
- `lib/model/task_model.dart` — primary Task model. Typical fields:
  - `id` — unique identifier
  - `title` — task title
  - `description` — details
  - `dueDate` — optional deadline
  - `priority` — priority enum
  - `completed` — boolean

Persistence: generated files like `task_model.g.dart` and `hive_registrar.g.dart` indicate usage of code generation and Hive for local storage.

## Services & Backend
- `lib/core/services/` — app services such as:
  - Local persistence (Hive)
  - Remote sync / Firebase (check `firebasetest/` and Android/iOS configs)
  - Business logic helpers

## Assets
- `assets/images/` — app images and icons used across screens.

## Build & CI notes
- Android: Gradle configs under `android/` and `app/`.
- iOS/macOS: native project in `ios/` and `macos/`.
- Web: `web/` contains `index.html` and manifest.

## Tests
- Unit & widget tests are under `test/` (e.g., `widget_test.dart`).
Run with `flutter test` as shown above.

## Contributing & Next Steps
- To extend documentation: list any missing feature in this file.
- Recommended improvements:
  - Add diagrams for navigation and data flow.
  - Expand model field docs with types and examples.
  - Document service interfaces and public methods.

If you want, I can:
- generate diagrams (Mermaid) for navigation and architecture,
- expand each feature section with file-level links,
- or produce a developer README with run/debug tips.
