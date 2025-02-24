import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          initial: true,
          page: PopularMoviesRoute.page,
          path: '/',
        ),
        AutoRoute(
          page: MovieDetailsRoute.page,
          path: '/details',
        ),
        AutoRoute(
          page: SearchMoviesRoute.page,
          path: '/search',
        ),
      ];
}
