import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entity/request/fetch_popular_movies_request.dart';

part 'fetch_popular_movies_request_dto.freezed.dart';

part 'fetch_popular_movies_request_dto.g.dart';

// ignore_for_file: invalid_annotation_target
@freezed
class FetchPopularMoviesRequestDto with _$FetchPopularMoviesRequestDto {
  const factory FetchPopularMoviesRequestDto({
    @JsonKey(includeIfNull: false) int? page,
    @JsonKey(includeIfNull: false) String? language,
    @JsonKey(includeIfNull: false) String? region,
  }) = _FetchPopularMoviesRequestDto;

  factory FetchPopularMoviesRequestDto.fromJson(Map<String, dynamic> json) =>
      _$FetchPopularMoviesRequestDtoFromJson(json);

  factory FetchPopularMoviesRequestDto.fromDomain(
    FetchPopularMoviesRequest domain,
  ) =>
      FetchPopularMoviesRequestDto(
        page: domain.page,
        language: domain.language,
        region: domain.region,
      );
}
