# Architecture Overview

The project follows a **Clean Architecture** and **Feature-First** structure to ensure scalability, testability, and maintainability.

## Directory Structure

- `lib/core/`: Shared logic, themes, components, and network configurations.
  - `components/`: Reusable UI widgets (AppButton, AppCard, etc.).
  - `theme/`: Design system definitions (AppTheme, AppColors).
  - `middleware/`: Navigation guards and role-based access control.
  - `config/`: Build-time configurations (DEMO_MODE).
- `lib/features/`: Domain-specific features.
  - `auth/`: Authentication logic and login views.
  - `exam/`: Exam player, builder, and details screens.
  - `room/`: Room management and student dashboards.
  - `reports/`: Analytics and monitoring dashboards.
- `lib/routes/`: Centralized route management.

## State Management
We use **GetX** for:
- **Dependency Injection**: Bindings for controllers and services.
- **State Management**: Reactive programming with `Obx` and `Worker` for autosave.
- **Routing**: Named routes with middleware support.

## Security (Anti-Cheat)
- **Android**: `FLAG_SECURE` to prevent screenshots/screen recording.
- **iOS**: Screen capture detection via `AppDelegate`.
- **Flutter**: Focus loss detection via `WidgetsBindingObserver` to track when a student leaves the app.
