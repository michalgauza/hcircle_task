import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/genres.dart';

part 'genres_dto.freezed.dart';

part 'genres_dto.g.dart';

@freezed
class GenresDto with _$GenresDto {
  const factory GenresDto({
    required int id,
    required String name,
  }) = _GenresDto;

  factory GenresDto.fromJson(Map<String, dynamic> json) =>
      _$GenresDtoFromJson(json);
}

extension GenresDtoExtension on GenresDto {
  Genres toDomain() => Genres(
        id: id,
        name: name,
      );
}
