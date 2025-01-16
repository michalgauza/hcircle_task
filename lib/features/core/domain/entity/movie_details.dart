import 'package:freezed_annotation/freezed_annotation.dart';

import 'genres.dart';

part 'movie_details.freezed.dart';

@freezed
class MovieDetails with _$MovieDetails {
  const factory MovieDetails({
    required int id,
    required String title,
    required String overview,
    required String releaseDate,
    required String posterPath,
    required double rating,
    required List<Genres> genres,
    required int runtime,
    required String originalLanguage,
  }) = _MovieDetails;
}
