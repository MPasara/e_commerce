// ignore_for_file: avoid_dynamic
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:loggy/loggy.dart';

import 'package:shopzy/common/domain/router/base_router.dart';

class GoRouterRouter extends BaseRouter {
  const GoRouterRouter({
    required super.routerDelegate,
    required super.routeInformationParser,
    super.routeInformationProvider,
    super.router,
  });

  @override
  BuildContext? get navigatorContext =>
      (router as GoRouter).routerDelegate.navigatorKey.currentContext;

  @override
  void pop() => (router as GoRouter).pop();

  @override
  void pushNamed(String routeName, {dynamic data}) =>
      (router as GoRouter).go(routeName, extra: data);

  @override
  void stackNamed(String routeName, {dynamic data}) =>
      (router as GoRouter).push(routeName, extra: data);

  @override
  void pushReplacementNamed(String routeName, {dynamic data}) =>
      (router as GoRouter).replace(routeName, extra: data);

  @override
  dynamic get getData =>
      throw UnsupportedError(
        'getData should not be called directly, instead it can be accessed through GoRouterState in GoRoute constructor',
      );

  @override
  Uri get currentLocationUri =>
      (routerDelegate as GoRouterDelegate).currentConfiguration.uri;

  //routeExists implementation is a workaround to known issue: https://github.com/flutter/flutter/issues/117514
  @override
  bool doesRouteExists(String route) {
    try {
      return (routeInformationParser as GoRouteInformationParser).configuration
          .findMatch(Uri.parse(route))
          .matches
          .isNotEmpty;
    } catch (err, stackTrace) {
      logDebug(
        'Error while trying to check if route exists: $err, stacktrace: $stackTrace',
      );
      return false;
    }
  }
}
