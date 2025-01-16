import 'package:flutter/services.dart';

enum EnvironmentType {
  dev,
}

class EnvironmentManager {
  EnvironmentManager._();

  static late EnvironmentType _current;

  static EnvironmentType get current => _current;

  static late String _tmdbApiKey;

  static String get tmdbApiKey => _tmdbApiKey;

  /// Run this method before the app starts to initialize the environment.
  static Future<void> init() async {
    const apiKey = String.fromEnvironment('tmdb_api_key');
    if (apiKey.isEmpty) {
      throw PlatformException(
        code: 'tmdb_api_key_not_set',
        message:
            'Please set the TMDB API key in run configuration.',
      );
    }
    _current = switch (appFlavor) {
      'dev' => EnvironmentType.dev,
      _ => throw UnimplementedError(
          'Unknown flavor: $appFlavor. Please use one of the following: ${EnvironmentType.values}',
        ),
    };
  }

  static String get baseUrl => switch (_current) {
        EnvironmentType.dev => 'https://api.themoviedb.org/3/',
      };
}
