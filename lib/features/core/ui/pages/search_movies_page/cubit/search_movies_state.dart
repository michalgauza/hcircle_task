import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../utils/failure.dart';
import '../../../../../../utils/ui/pagination/pagination_state.dart';
import '../../../../domain/entity/movie.dart';

part 'search_movies_state.freezed.dart';

@freezed
class SearchMoviesState with _$SearchMoviesState {
  const factory SearchMoviesState.initial() = _Initial;

  const factory SearchMoviesState.idle({
    required List<Movie> movies,
    required int page,
    required int totalPages,
    required PaginationState paginationState,
  }) = _Indle;

  const factory SearchMoviesState.loading() = _Loading;

  const factory SearchMoviesState.error(Failure failure) = _Error;
}
