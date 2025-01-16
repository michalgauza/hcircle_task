import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/movie.dart';

part 'movie_dto.freezed.dart';

part 'movie_dto.g.dart';

@freezed
class MovieDto with _$MovieDto {
  const factory MovieDto({
    required int id,
    required String title,
    required String originalTitle,
    required String releaseDate,
    required String? posterPath,
    required double voteAverage,
  }) = _MovieDto;

  factory MovieDto.fromJson(Map<String, dynamic> json) =>
      _$MovieDtoFromJson(json);
}

extension MovieDtoExtension on MovieDto {
  Movie toDomain() => Movie(
        id: id,
        title: title,
        originalTitle: originalTitle,
        releaseDate: releaseDate,
        // Magick links from documentation https://developer.themoviedb.org/docs/image-basics
        smallPoster: 'https://image.tmdb.org/t/p/w300/$posterPath',
        bigPoster: 'https://image.tmdb.org/t/p/original/$posterPath',
        rating: voteAverage,
      );
}
