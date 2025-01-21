import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../../../utils/failure.dart';
import '../../../../../../../../utils/ui/pagination/pagination_state.dart';
import '../../../../../../domain/entity/movie.dart';

part 'popular_movies_state.freezed.dart';

@freezed
class PopularMoviesState with _$PopularMoviesState {
  const factory PopularMoviesState.idle({
    required List<Movie> movies,
    required int page,
    required int totalPages,
    required PaginationState paginationState,
  }) = _Indle;

  const factory PopularMoviesState.loading() = _Loading;

  const factory PopularMoviesState.error(Failure failure) = _Error;
}
