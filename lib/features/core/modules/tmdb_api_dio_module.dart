import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../utils/environment_manager.dart';
import '../../../utils/injectable/injectable.dart';

const _timeout = Duration(seconds: 5);
const tmdbApiDioModuleName = 'tmdbApiDio';

@module
abstract class ApiDioModule {
  @Named(tmdbApiDioModuleName)
  @Singleton()
  Dio get client => Dio(
        BaseOptions(
          baseUrl: EnvironmentManager.baseUrl,
          connectTimeout: _timeout,
          receiveTimeout: _timeout,
          sendTimeout: _timeout,
        ),
      );
}

void registerInterceptors() {
  final dio = getIt<Dio>(instanceName: tmdbApiDioModuleName);
  dio.interceptors.addAll(
    [
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        compact: false,
      ),
    ],
  );
}
