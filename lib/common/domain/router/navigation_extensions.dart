// ignore_for_file: avoid_dynamic
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:shopzy/features/home/presentation/home_page.dart';
import 'package:shopzy/common/domain/providers/base_router_provider.dart';
import 'package:shopzy/common/domain/providers/global_navigation_provider.dart';
import 'package:shopzy/common/domain/utils/string_extensions.dart';
import 'package:shopzy/common/domain/router/route_action.dart';

extension NavigationExtensions on WidgetRef {
  void pop() =>
      read(globalNavigationProvider.notifier).update((_) => PopAction());

  void pushNamed(String routeName, {dynamic data}) => read(
    globalNavigationProvider.notifier,
  ).update((_) => PushNamedAction(routeName, data));

  void stackNamed(String routeName, {dynamic data}) => read(
    globalNavigationProvider.notifier,
  ).update((_) => StackNamedAction(routeName, data));

  void pushReplacementNamed(String routeName, {dynamic data}) => read(
    globalNavigationProvider.notifier,
  ).update((_) => PushReplacementNamedAction(routeName, data));

  ({String currentRouteName, Map<String, String?> queryParameters})
  get _currentNavigationLocation {
    final location = read(baseRouterProvider).currentLocationUri;
    final currentRoute = location.path;
    return (
      currentRouteName: currentRoute == HomePage.routeName ? '' : currentRoute,
      queryParameters: location.queryParameters,
    );
  }

  String getRouteNameFromCurrentLocation(
    String routeName, {
    bool keepExistingQueryString = true,
  }) {
    final (:currentRouteName, :queryParameters) = _currentNavigationLocation;
    final routeNameUri = Uri.tryParse(routeName);
    final newRoute = '$currentRouteName${routeNameUri?.path ?? ''}';
    final newQueryParameters =
        keepExistingQueryString ? Map.of(queryParameters) : <String, dynamic>{};
    if (routeNameUri?.queryParameters.isNotEmpty == true) {
      for (final item in routeNameUri!.queryParameters.entries) {
        newQueryParameters.containsKey(item.key)
            ? newQueryParameters[item.key] = item.value
            : newQueryParameters.putIfAbsent(item.key, () => item.value);
      }
    }
    final newRouteUri = Uri(
      path: newRoute,
      queryParameters:
          newQueryParameters.isNotEmpty ? newQueryParameters : null,
    );
    return newRouteUri.toString();
  }

  String removeRouteNameFromCurrentLocation(
    String routeName, {
    bool keepExistingQueryString = false,
  }) {
    final (:currentRouteName, :queryParameters) = _currentNavigationLocation;
    final routeNameUri = Uri.tryParse(routeName);
    final newRoute =
        routeNameUri?.path != null
            ? currentRouteName.replaceLast(routeNameUri!.path, '')
            : currentRouteName;
    final newQueryParameters =
        keepExistingQueryString ? Map.of(queryParameters) : <String, dynamic>{};
    if (routeNameUri?.queryParameters.isNotEmpty == true) {
      for (final item in routeNameUri!.queryParameters.entries) {
        newQueryParameters.remove(item.key);
      }
    }
    final newRouteUri = Uri(
      path: newRoute,
      queryParameters:
          newQueryParameters.isNotEmpty ? newQueryParameters : null,
    );
    return newRouteUri.toString();
  }
}
