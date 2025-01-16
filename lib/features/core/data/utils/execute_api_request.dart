import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../utils/failure.dart';
import '../../../../utils/log.dart';
import '../dto/api_error_dto.dart';

Future<Either<Failure, T>> executeApiRequest<T>(
  Future<T> Function() callback,
  String actionName,
) async {
  try {
    return right(await callback());
  } catch (e, st) {
    log.severe(e, st);
    if (e is DioException) {
      if (e.type == DioExceptionType.badResponse) {
        try {
          final apiError =
              ApiErrorDto.fromJson(e.response!.data as Map<String, dynamic>);
          return left(Failure.response(apiError.statusMessage));
        } catch (e, st) {
          log.severe('Error while parsing api failure', e, st);
          return left(const Failure.unknown());
        }
      }
      return left(const Failure.unknown());
    }
    return left(const Failure.unknown());
  }
}
