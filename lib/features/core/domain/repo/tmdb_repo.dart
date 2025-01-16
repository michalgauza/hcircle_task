import 'package:dartz/dartz.dart';

import '../../../../utils/failure.dart';
import '../entity/movie.dart';
import '../entity/response/pagination_response.dart';

abstract class TmdbRepo {
  Future<Either<Failure, PaginationResponse<Movie>>> fetchPopularMovies();
}
