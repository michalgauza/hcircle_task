import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entity/response/pagination_response.dart';

part 'pagination_response_dto.freezed.dart';

part 'pagination_response_dto.g.dart';

@freezed
class PaginationResponseDto with _$PaginationResponseDto {
  const factory PaginationResponseDto({
    required int page,
    required int totalResults,
    // TODO(Michal): Try to use custom converter or smth
    required List<Map<String, dynamic>> results,
    required int totalPages,
  }) = _PaginationResponseDto;

  factory PaginationResponseDto.fromJson(Map<String, dynamic> json) =>
      _$PaginationResponseDtoFromJson(json);
}

extension PaginationResponseDtoX on PaginationResponseDto {
  PaginationResponse<T> toDomain<T>(
    List<T> Function(List<Map<String, dynamic>>) converter,
  ) =>
      PaginationResponse(
        page: page,
        totalResults: totalResults,
        results: converter(results),
        totalPages: totalPages,
      );
}
