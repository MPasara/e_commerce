// ignore_for_file: avoid_dynamic

import 'package:flutter/widgets.dart';

abstract class BaseRouter {
  final RouterDelegate<Object> routerDelegate;
  final RouteInformationParser<Object> routeInformationParser;
  final RouteInformationProvider? routeInformationProvider;
  final dynamic router;

  const BaseRouter({
    required this.routerDelegate,
    required this.routeInformationParser,
    this.routeInformationProvider,
    this.router,
  });

  BuildContext? get navigatorContext;

  void pushNamed(String routeName, {dynamic data});

  void stackNamed(String routeName, {dynamic data});

  void pushReplacementNamed(String routeName, {dynamic data});

  void pop();

  dynamic get getData;

  Uri get currentLocationUri;

  bool doesRouteExists(String route);
}
