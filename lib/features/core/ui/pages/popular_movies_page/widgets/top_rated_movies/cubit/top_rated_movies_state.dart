import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../../../utils/failure.dart';
import '../../../../../../../../utils/ui/pagination/pagination_state.dart';
import '../../../../../../domain/entity/movie.dart';

part 'top_rated_movies_state.freezed.dart';

@freezed
class TopRatedMoviesState with _$TopRatedMoviesState {
  const factory TopRatedMoviesState.idle({
    required List<Movie> movies,
    required int page,
    required int totalPages,
    required PaginationState paginationState,
  }) = _Indle;

  const factory TopRatedMoviesState.loading() = _Loading;

  const factory TopRatedMoviesState.error(Failure failure) = _Error;
}
