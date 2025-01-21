import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entity/request/fetch_movie_details_request.dart';
import '../../../../domain/repo/tmdb_repo.dart';
import 'movie_details_state.dart';
export 'movie_details_state.dart';

@injectable
class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  MovieDetailsCubit(
    this._tmdbRepo,
    @factoryParam this.movieId,
  ) : super(const MovieDetailsState.loading());

  final TmdbRepo _tmdbRepo;
  final int movieId;

  Future<void> init() async {
    emit(
      (await _tmdbRepo.fetchMovieDetails(
        FetchMovieDetailsRequest(id: movieId),
      ))
          .fold(
        (l) => MovieDetailsState.error(l),
        (r) => MovieDetailsState.loaded(r),
      ),
    );
  }

  Future<void> retry() async {
    emit(const MovieDetailsState.loading());
    await init();
  }
}
