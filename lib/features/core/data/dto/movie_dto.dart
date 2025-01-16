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
  }) = _MovieDto;

  factory MovieDto.fromJson(Map<String, dynamic> json) =>
      _$MovieDtoFromJson(json);
}

extension MovieDtoExtension on MovieDto {
  Movie toDomain() => Movie(
        id: id,
        title: title,
        originalTitle: originalTitle,
      );
}
