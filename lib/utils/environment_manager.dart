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
  static void init()  {
    const apiKey = String.fromEnvironment('tmdb_api_key');
    if (apiKey.isEmpty) {
      throw Exception(
        'tmdb_api_key not set. Please set the TMDB API key in run configuration.',
      );
    }
    _tmdbApiKey = apiKey;
    _current = switch (appFlavor) {
      'dev' => EnvironmentType.dev,
      _ => throw Exception(
          'Unknown flavor: $appFlavor. Please use one of the following: ${EnvironmentType.values.map((e) => e.name)}',
        ),
    };
  }

  static String get baseUrl => switch (_current) {
        EnvironmentType.dev => 'https://api.themoviedb.org/3/',
      };
}
