import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entity/request/search_movies_request.dart';

part 'search_movies_request_dto.freezed.dart';

part 'search_movies_request_dto.g.dart';

// ignore_for_file: invalid_annotation_target
@freezed
class SearchMoviesRequestDto with _$SearchMoviesRequestDto {
  const factory SearchMoviesRequestDto({
    @JsonKey(includeIfNull: false) required String query,
    @JsonKey(includeIfNull: false) int? page,
  }) = _SearchMoviesRequestDto;

  factory SearchMoviesRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SearchMoviesRequestDtoFromJson(json);

  factory SearchMoviesRequestDto.fromDomain(
      SearchMoviesRequest domain,
  ) =>
      SearchMoviesRequestDto(
        page: domain.page,
        query: domain.query,
      );
}
