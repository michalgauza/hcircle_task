import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../utils/ui/pagination/pagination_helper.dart';
import '../../../../../../../../utils/ui/pagination/pagination_state.dart';
import '../../../../../../domain/entity/movie.dart';
import '../../../../../../domain/entity/request/fetch_popular_movies_request.dart';
import '../../../../../../domain/entity/response/pagination_response.dart';
import '../../../../../../domain/repo/tmdb_repo.dart';
import 'top_rated_movies_state.dart';
export 'top_rated_movies_state.dart';

@injectable
class TopRatedMoviesCubit extends Cubit<TopRatedMoviesState>
    // with PaginationHelperMixin
    implements PaginationHelper {
  TopRatedMoviesCubit(this._tmdbRepo)
      : super(const TopRatedMoviesState.loading());

  int _page = 1;

  int get page => _page;
  int _totalPages = 2;

  int get totalPages => _totalPages;

  void updatePages<T>(PaginationResponse<T> response) {
    _totalPages = response.totalPages;
    _page++;
  }

  PaginationState get getPaginationState => _totalPages < _page
      ? const PaginationState.end()
      : const PaginationState.idle();




  final TmdbRepo _tmdbRepo;

  PaginationState _paginationState = const PaginationState.idle();
  final List<Movie> _movies = [];

  TopRatedMoviesState get _getIdle => TopRatedMoviesState.idle(
        movies: _movies,
        page: page,
        totalPages: totalPages,
        paginationState: _paginationState,
      );

  Future<void> init() async {
    emit(
      (await _tmdbRepo.fetchTopRatedMovies(
        FetchPopularMoviesRequest(page: page),
      ))
          .fold(
        TopRatedMoviesState.error,
        (response) {
          updatePages(response);
          _movies.addAll(response.results);
          return _getIdle;
        },
      ),
    );
  }

  @override
  Future<void> fetchNext() async {
    // Fetch only when PaginationState is idle to prevent too many requests
    await _paginationState.mapOrNull(
      idle: (_) async {
        await _paginationFetch();
      },
    );
  }

  @override
  Future<void> retryFetch() async {
    // Fetch only when PaginationState is error to prevent too many requests
    await _paginationState.mapOrNull(
      error: (_) async {
        await _paginationFetch();
      },
    );
  }

  Future<void> _paginationFetch() async {
    // Change PaginationState to loading and emit updated state
    _paginationState = const PaginationState.loading();
    emit(_getIdle);
    // Fetch next page
    _paginationState = (await _tmdbRepo.fetchTopRatedMovies(
      FetchPopularMoviesRequest(page: page),
    ))
        .fold(
      // Change PaginationState to error
      PaginationState.error,
      (r) {
        // Change PaginationState to idle and update pages and movies
        _movies.addAll(r.results);
        updatePages(r);
        return getPaginationState;
      },
    );
    // Emit updated state
    emit(_getIdle);
  }

  Future<void> retry() async {
    emit(const TopRatedMoviesState.loading());
    await init();
  }
}
