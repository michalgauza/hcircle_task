import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/movie_details.dart';
import 'genres_dto.dart';

part 'movie_details_dto.freezed.dart';

part 'movie_details_dto.g.dart';

@freezed
class MovieDetailsDto with _$MovieDetailsDto {
  const factory MovieDetailsDto({
    required int id,
    required String title,
    required String overview,
    required String releaseDate,
    required String? posterPath,
    required double voteAverage,
    required List<GenresDto> genres,
    required int runtime,
    required String originalLanguage,
  }) = _MovieDetailsDto;

  factory MovieDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsDtoFromJson(json);
}

extension MovieDetailsDtoExtension on MovieDetailsDto {
  MovieDetails toDomain() => MovieDetails(
        id: id,
        title: title,
        releaseDate: releaseDate,
        // Magick links from documentation https://developer.themoviedb.org/docs/image-basics
        posterPath: 'https://image.tmdb.org/t/p/original/$posterPath',
        rating: voteAverage,
        genres: genres.map((e) => e.toDomain()).toList(),
        originalLanguage: originalLanguage,
        overview: overview,
        runtime: runtime,
      );
}
