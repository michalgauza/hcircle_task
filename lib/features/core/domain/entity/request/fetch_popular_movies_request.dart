import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_popular_movies_request.freezed.dart';

@freezed
class FetchPopularMoviesRequest with _$FetchPopularMoviesRequest {
  const factory FetchPopularMoviesRequest({
    int? page,
    String? language,
    String? region,
  }) = _FetchPopularMoviesRequest;
}
