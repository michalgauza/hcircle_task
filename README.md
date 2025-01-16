# hcircle_task


## Getting Started

### Run build_runner to generate code for json_serializable

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Run intl_generator to generate code for intl

```bash
flutter pub run intl_generator:generate
```

### Run app with dev flavor and with api key

```bash 
flutter run lib/main.dart --flavor dev --dart-define tmdb_api_key=[YOUR_API_KEY]
```
