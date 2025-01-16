import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../utils/environment_manager.dart';
import '../../../../utils/failure.dart';
import '../../domain/entity/movie.dart';
import '../../domain/entity/response/pagination_response.dart';
import '../../domain/repo/tmdb_repo.dart';
import '../../modules/tmdb_api_dio_module.dart';
import '../dto/movie_dto.dart';
import '../dto/response/pagination_response_dto.dart';
import '../utils/execute_api_request.dart';

@Injectable(as: TmdbRepo)
class TmdbRepoImpl implements TmdbRepo {
  TmdbRepoImpl(@Named(tmdbApiDioModuleName) this._dio);

  final Dio _dio;

  @override
  Future<Either<Failure, PaginationResponse<Movie>>> fetchPopularMovies() =>
      executeApiRequest(
        () async {
          final response = await _dio.get<Map<String, dynamic>>(
            'https://api.themoviedb.org/3/movie/popular',
            queryParameters: {
              'api_key': EnvironmentManager.tmdbApiKey,
            },
          );
          return PaginationResponseDto.fromJson(response.data!).toDomain(
            (data) => data.map((e) => MovieDto.fromJson(e).toDomain()).toList(),
          );
        },
        'fetchPopularMovies',
      );
}
