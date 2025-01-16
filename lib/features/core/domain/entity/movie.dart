import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie.freezed.dart';

@freezed
class Movie with _$Movie {
  const factory Movie({
    required int id,
    required String title,
    required String originalTitle,
    required String releaseDate,
    required String smallPoster,
    required String bigPoster,
    required double rating,
  }) = _Movie;
}
