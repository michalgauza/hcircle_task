import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/repo/tmdb_repo.dart';
import 'popular_movies_state.dart';
export 'popular_movies_state.dart';

@injectable
class PopularMoviesCubit extends Cubit<PopularMoviesState> {
  PopularMoviesCubit(this._tmdbRepo)
      : super(const PopularMoviesState.loading());
  final TmdbRepo _tmdbRepo;

  PaginationState _paginationState = const PaginationState.idle();

  Future<void> init() async {
    emit(
      (await _tmdbRepo.fetchPopularMovies()).fold(
        PopularMoviesState.error,
        (response) => PopularMoviesState.idle(
          movies: response.results,
          page: response.page,
          totalPages: response.totalPages,
          paginationState: _paginationState,
        ),
      ),
    );
  }

  Future<void> retry() async {
    emit(const PopularMoviesState.loading());
    await init();
  }
}
