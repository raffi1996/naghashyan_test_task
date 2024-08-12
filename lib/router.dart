import 'package:auto_route/auto_route.dart';

import 'router.gr.dart';

export 'router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Screen,Route',
)
class AppRouter extends $AppRouter {
  AppRouter({super.navigatorKey});

  @override
  RouteType get defaultRouteType => const RouteType.custom(
        opaque: false,
        durationInMilliseconds: 100,
        reverseDurationInMilliseconds: 100,
        transitionsBuilder: TransitionsBuilders.fadeIn,
      );

  @override
  final List<AutoRoute> routes = [
    CustomRoute(
      page: HomeRoute.page,
      initial: true,
      path: '/home',
      opaque: false,
    ),
  ];
}
