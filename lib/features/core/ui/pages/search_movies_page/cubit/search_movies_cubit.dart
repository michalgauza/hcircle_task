import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../utils/debouncer.dart';
import '../../../../../../utils/ui/pagination/pagination_helper.dart';
import '../../../../../../utils/ui/pagination/pagination_state.dart';
import '../../../../domain/entity/movie.dart';
import '../../../../domain/entity/request/search_movies_request.dart';
import '../../../../domain/repo/tmdb_repo.dart';
import 'search_movies_state.dart';
export 'search_movies_state.dart';

@injectable
class SearchMoviesCubit extends Cubit<SearchMoviesState>
    with PaginationHelperMixin
    implements PaginationHelper {
  SearchMoviesCubit(this._tmdbRepo) : super(const SearchMoviesState.initial());
  final TmdbRepo _tmdbRepo;

  final _debouncer = Debouncer(milliseconds: 500);

  PaginationState _paginationState = const PaginationState.idle();
  final List<Movie> _movies = [];

  SearchMoviesState get _getIdle => SearchMoviesState.idle(
        movies: _movies,
        page: page,
        totalPages: totalPages,
        paginationState: _paginationState,
      );

  String query = '';

  void searchMovies(String q) {
    query = q;
    _debouncer.cancel();
    if (query.isEmpty) {
      emit(const SearchMoviesState.initial());
      return;
    }
    emit(const SearchMoviesState.loading());
    _debouncer.run(() async {
      var state =
          (await _tmdbRepo.searchMovies(SearchMoviesRequest(query: query)))
              .fold(
        SearchMoviesState.error,
        (r) {
          _movies
            ..clear()
            ..addAll(r.results);
          updatePages(r);
          return _getIdle;
        },
      );
      if (query.isEmpty) {
        state = const SearchMoviesState.initial();
      }
      emit(state);
    });
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
    _paginationState = (await _tmdbRepo.searchMovies(
      SearchMoviesRequest(
        query: query,
        page: page,
      ),
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
}
