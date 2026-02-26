# Local Setup & Verification

## Prerequisites
- Flutter SDK (latest stable)
- Android Studio / VS Code
- Chrome (for web verification)

## Installation
```bash
flutter pub get
```

## Running the App
### Demo Mode (UI/UX Review)
To enable mock login and view all screens without a backend:
```bash
flutter run --dart-define=DEMO_MODE=true
```

### Production Mode
```bash
flutter run --dart-define=DEMO_MODE=false
```

## Running Tests
### Unit & Widget Tests
```bash
flutter test
```

### Visual Verification (Goldens)
```bash
flutter test --update-goldens
```

## Deployment
### Web Build
```bash
flutter build web --profile --dart-define=DEMO_MODE=true
```
