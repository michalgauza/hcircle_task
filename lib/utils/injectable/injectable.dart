import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../../features/core/modules/tmdb_api_dio_module.dart';
import 'injectable.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
Future<void> injectDependencies() async {
  $initGetIt(getIt);
  registerInterceptors();
}
