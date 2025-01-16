import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_movie_details_request.freezed.dart';

@freezed
class FetchMovieDetailsRequest with _$FetchMovieDetailsRequest {
  const factory FetchMovieDetailsRequest({
    required int id,
  }) = _FetchMovieDetailsRequest;
}
