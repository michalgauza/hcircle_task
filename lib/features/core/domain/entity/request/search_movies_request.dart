import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_movies_request.freezed.dart';

@freezed
class SearchMoviesRequest with _$SearchMoviesRequest {
  const factory SearchMoviesRequest({
    required String query,
    int? page,
  }) = _SearchMoviesRequest;
}
