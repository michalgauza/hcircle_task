import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../utils/environment_manager.dart';
import '../../../../utils/failure.dart';
import '../../domain/entity/movie.dart';
import '../../domain/entity/movie_details.dart';
import '../../domain/entity/request/fetch_movie_details_request.dart';
import '../../domain/entity/request/fetch_popular_movies_request.dart';
import '../../domain/entity/request/search_movies_request.dart';
import '../../domain/entity/response/pagination_response.dart';
import '../../domain/repo/tmdb_repo.dart';
import '../../modules/tmdb_api_dio_module.dart';
import '../dto/movie_details_dto.dart';
import '../dto/movie_dto.dart';
import '../dto/request/fetch_popular_movies_request_dto.dart';
import '../dto/request/search_movies_request_dto.dart';
import '../dto/response/pagination_response_dto.dart';
import '../utils/execute_api_request.dart';

@Injectable(as: TmdbRepo)
class TmdbRepoImpl implements TmdbRepo {
  TmdbRepoImpl(@Named(tmdbApiDioModuleName) this._dio);

  final Dio _dio;

  @override
  Future<Either<Failure, PaginationResponse<Movie>>> fetchTopRatedMovies(
    FetchPopularMoviesRequest request,
  ) =>
      executeApiRequest(
        () async => PaginationResponseDto.fromJson(
          (await _dio.get<Map<String, dynamic>>(
            'https://api.themoviedb.org/3/movie/top_rated',
            queryParameters: {
              'api_key': EnvironmentManager.tmdbApiKey,
              ...FetchPopularMoviesRequestDto.fromDomain(request).toJson(),
            },
          ))
              .data!,
        ).toDomain(
          (data) => data.map((e) => MovieDto.fromJson(e).toDomain()).toList(),
        ),
        'fetchTopRatedMovies',
      );

  @override
  Future<Either<Failure, PaginationResponse<Movie>>> fetchPopularMovies(
    FetchPopularMoviesRequest request,
  ) =>
      executeApiRequest(
        () async => PaginationResponseDto.fromJson(
          (await _dio.get<Map<String, dynamic>>(
            'https://api.themoviedb.org/3/movie/popular',
            queryParameters: {
              'api_key': EnvironmentManager.tmdbApiKey,
              ...FetchPopularMoviesRequestDto.fromDomain(request).toJson(),
            },
          ))
              .data!,
        ).toDomain(
          (data) => data.map((e) => MovieDto.fromJson(e).toDomain()).toList(),
        ),
        'fetchPopularMovies',
      );

  @override
  Future<Either<Failure, MovieDetails>> fetchMovieDetails(
    FetchMovieDetailsRequest request,
  ) =>
      executeApiRequest(
        () async => MovieDetailsDto.fromJson(
          (await _dio.get<Map<String, dynamic>>(
            'https://api.themoviedb.org/3/movie/${request.id}',
            queryParameters: {
              'api_key': EnvironmentManager.tmdbApiKey,
            },
          ))
              .data!,
        ).toDomain(),
        'fetchMovieDetails',
      );

  @override
  Future<Either<Failure, PaginationResponse<Movie>>> searchMovies(
    SearchMoviesRequest request,
  ) async =>
      executeApiRequest(
        () async => PaginationResponseDto.fromJson(
          (await _dio.get<Map<String, dynamic>>(
            'https://api.themoviedb.org/3/search/movie',
            queryParameters: {
              'api_key': EnvironmentManager.tmdbApiKey,
              ...SearchMoviesRequestDto.fromDomain(request).toJson(),
            },
          ))
              .data!,
        ).toDomain(
          (data) => data.map((e) => MovieDto.fromJson(e).toDomain()).toList(),
        ),
        'searchMovies',
      );
}
