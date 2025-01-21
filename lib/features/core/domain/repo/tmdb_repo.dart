import 'package:dartz/dartz.dart';

import '../../../../utils/failure.dart';
import '../entity/movie.dart';
import '../entity/movie_details.dart';
import '../entity/request/fetch_movie_details_request.dart';
import '../entity/request/fetch_popular_movies_request.dart';
import '../entity/request/search_movies_request.dart';
import '../entity/response/pagination_response.dart';

abstract class TmdbRepo {
  Future<Either<Failure, PaginationResponse<Movie>>> fetchTopRatedMovies(
    FetchPopularMoviesRequest request,
  );

  Future<Either<Failure, PaginationResponse<Movie>>> fetchPopularMovies(
    FetchPopularMoviesRequest request,
  );

  Future<Either<Failure, MovieDetails>> fetchMovieDetails(
    FetchMovieDetailsRequest request,
  );

  Future<Either<Failure, PaginationResponse<Movie>>> searchMovies(
    SearchMoviesRequest request,
  );
}
