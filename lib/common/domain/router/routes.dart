import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopzy/common/domain/router/go_router_state_extensions.dart';
import 'package:shopzy/common/domain/utils/string_extensions.dart';
import 'package:shopzy/example/example_routes.dart';
import 'package:shopzy/features/dashboard/presentation/home_page.dart';
import 'package:shopzy/features/directories/presentation/account_page.dart';
import 'package:shopzy/features/home/presentation/main_page.dart';
import 'package:shopzy/features/login/presentation/login_page.dart';
import 'package:shopzy/features/notifications/presentation/all_notifications_page.dart';
import 'package:shopzy/features/notifications/presentation/notification_details_page.dart';
import 'package:shopzy/features/notifications/presentation/order_page.dart';
import 'package:shopzy/features/register/presentation/register_page.dart';
import 'package:shopzy/features/reset_password/presentation/reset_password_page.dart';
import 'package:shopzy/features/users/presentation/user_details_page.dart';
import 'package:shopzy/features/users/presentation/wishlist_page.dart';

List<RouteBase> getRoutes({
  required GlobalKey<NavigatorState> rootNavigatorKey,
  bool stateful = true,
}) => [
  GoRoute(
    path: MainPage.routeName,
    redirect: (context, state) => HomePage.routeName,
  ),
  if (stateful)
    _statefulShellRoute(rootNavigatorKey: rootNavigatorKey)
  else
    _shellRoute(rootNavigatorKey: rootNavigatorKey),
  GoRoute(
    path: LoginPage.routeName,
    builder: (context, state) => LoginPage(),
    routes: [
      GoRoute(
        path: ResetPasswordPage.routeName.lastPart,
        builder: (context, state) => ResetPasswordPage(),
      ),
      GoRoute(
        path: RegisterPage.routeName.lastPart,
        builder: (context, state) => RegisterPage(),
      ),
    ],
  ),
];

RouteBase _statefulShellRoute({
  required GlobalKey<NavigatorState> rootNavigatorKey,
}) => StatefulShellRoute.indexedStack(
  builder:
      (context, state, navigationShell) =>
          MainPage(navigationShell: navigationShell),
  branches: [
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: HomePage.routeName,
          builder: (context, state) => HomePage(),
          routes: [
            GoRoute(
              path: UserDetailsPage.routeName.removeLeadingSlash,
              builder:
                  (context, state) => UserDetailsPage(
                    userId:
                        state.getPathParameterByName<int>(
                          name: UserDetailsPage.pathPattern.removeLeadingColon,
                        )!,
                  ),
              redirect:
                  (context, state) => state.redirectIfPathParameterValid<int>(
                    pathParameterName:
                        UserDetailsPage.pathPattern.removeLeadingColon,
                    redirectTo: HomePage.routeName,
                  ),
            ),
            getExampleRoutes(rootNavigatorKey: rootNavigatorKey),
          ],
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: WishlistPage.routeName,
          builder: (context, state) => WishlistPage(),
          routes: [
            GoRoute(
              path: UserDetailsPage.routeName.removeLeadingSlash,
              builder:
                  (context, state) => UserDetailsPage(
                    userId:
                        state.getPathParameterByName<int>(
                          name: UserDetailsPage.pathPattern.removeLeadingColon,
                        )!,
                  ),
              redirect:
                  (context, state) => state.redirectIfPathParameterValid<int>(
                    pathParameterName:
                        UserDetailsPage.pathPattern.removeLeadingColon,
                    redirectTo: WishlistPage.routeName,
                  ),
            ),
          ],
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: OrderPage.routeName,
          builder: (context, state) => OrderPage(),
          routes: [
            GoRoute(
              path: AllNotificationsPage.routeName.removeLeadingSlash,
              builder: (context, state) => AllNotificationsPage(),
              routes: [
                GoRoute(
                  path: NotificationDetailsPage.routeName.removeLeadingSlash,
                  builder:
                      (context, state) => NotificationDetailsPage(
                        notificationId:
                            state.getPathParameterByName<int>(
                              name:
                                  NotificationDetailsPage
                                      .pathPattern
                                      .removeLeadingColon,
                            )!,
                      ),
                  redirect:
                      (
                        context,
                        state,
                      ) => state.redirectIfPathParameterValid<int>(
                        pathParameterName:
                            NotificationDetailsPage
                                .pathPattern
                                .removeLeadingColon,
                        redirectTo:
                            '${OrderPage.routeName}${AllNotificationsPage.routeName}',
                      ),
                ),
              ],
            ),
            GoRoute(
              path: NotificationDetailsPage.routeName.removeLeadingSlash,
              builder:
                  (context, state) => NotificationDetailsPage(
                    notificationId:
                        state.getPathParameterByName<int>(
                          name:
                              NotificationDetailsPage
                                  .pathPattern
                                  .removeLeadingColon,
                        )!,
                  ),
              redirect:
                  (context, state) => state.redirectIfPathParameterValid<int>(
                    pathParameterName:
                        NotificationDetailsPage.pathPattern.removeLeadingColon,
                    redirectTo: OrderPage.routeName,
                  ),
            ),
          ],
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: AccountPage.routeName,
          builder: (context, state) => AccountPage(),
          routes: [
            _buildRoutesRecursively(
              depth: 10,
              pathCallback: (depth) => AccountPage.pathPattern(depth),
              builderCallback:
                  (context, state, depth) => AccountPage(
                    directoryName:
                        state.pathParameters[AccountPage.pathPattern(
                          depth,
                        ).removeLeadingColon],
                    canGoDeeper: depth > 1,
                  ),
            ),
          ],
        ),
      ],
    ),
  ],
);

RouteBase _shellRoute({
  required GlobalKey<NavigatorState> rootNavigatorKey,
}) => ShellRoute(
  builder: (context, state, child) => MainPage(child: child),
  routes: [
    GoRoute(
      path: HomePage.routeName,
      builder: (context, state) => HomePage(),
      routes: [
        GoRoute(
          path: UserDetailsPage.routeName.removeLeadingSlash,
          builder:
              (context, state) => UserDetailsPage(
                userId:
                    state.getPathParameterByName(
                      name: UserDetailsPage.pathPattern.removeLeadingColon,
                    )!,
              ),
          redirect:
              (context, state) => state.redirectIfPathParameterValid<int>(
                pathParameterName:
                    UserDetailsPage.pathPattern.removeLeadingColon,
                redirectTo: HomePage.routeName,
              ),
        ),
      ],
    ),
    GoRoute(
      path: WishlistPage.routeName,
      builder: (context, state) => WishlistPage(),
      routes: [
        GoRoute(
          path: UserDetailsPage.routeName.removeLeadingSlash,
          builder:
              (context, state) => UserDetailsPage(
                userId:
                    state.getPathParameterByName(
                      name: UserDetailsPage.pathPattern.removeLeadingColon,
                    )!,
              ),
          redirect:
              (context, state) => state.redirectIfPathParameterValid<int>(
                pathParameterName:
                    UserDetailsPage.pathPattern.removeLeadingColon,
                redirectTo: WishlistPage.routeName,
              ),
        ),
      ],
    ),
    GoRoute(
      path: OrderPage.routeName,
      builder: (context, state) => OrderPage(),
      routes: [
        GoRoute(
          path: AllNotificationsPage.routeName.removeLeadingSlash,
          builder: (context, state) => AllNotificationsPage(),
          routes: [
            GoRoute(
              path: NotificationDetailsPage.routeName.removeLeadingSlash,
              builder:
                  (context, state) => NotificationDetailsPage(
                    notificationId:
                        state.getPathParameterByName<int>(
                          name:
                              NotificationDetailsPage
                                  .pathPattern
                                  .removeLeadingColon,
                        )!,
                  ),
              redirect:
                  (context, state) => state.redirectIfPathParameterValid<int>(
                    pathParameterName:
                        NotificationDetailsPage.pathPattern.removeLeadingColon,
                    redirectTo:
                        '${OrderPage.routeName}${AllNotificationsPage.routeName}',
                  ),
            ),
          ],
        ),
        GoRoute(
          path: NotificationDetailsPage.routeName.removeLeadingSlash,
          builder:
              (context, state) => NotificationDetailsPage(
                notificationId:
                    state.getPathParameterByName<int>(
                      name:
                          NotificationDetailsPage
                              .pathPattern
                              .removeLeadingColon,
                    )!,
              ),
          redirect:
              (context, state) => state.redirectIfPathParameterValid<int>(
                pathParameterName:
                    NotificationDetailsPage.pathPattern.removeLeadingColon,
                redirectTo: OrderPage.routeName,
              ),
        ),
      ],
    ),
    GoRoute(
      path: AccountPage.routeName,
      builder: (context, state) => AccountPage(),
      routes: [
        _buildRoutesRecursively(
          depth: 10,
          pathCallback: (depth) => AccountPage.pathPattern(depth),
          builderCallback:
              (context, state, depth) => AccountPage(
                directoryName:
                    state.pathParameters[AccountPage.pathPattern(
                      depth,
                    ).removeLeadingColon],
                canGoDeeper: depth > 1,
              ),
        ),
      ],
    ),
  ],
);

GoRoute _buildRoutesRecursively({
  required int depth,
  required Function(int depth) pathCallback,
  Page Function(BuildContext context, GoRouterState state, int depth)?
  pageBuilderCallback,
  Widget Function(BuildContext context, GoRouterState state, int depth)?
  builderCallback,
  GlobalKey<NavigatorState>? parentNavigatorKey,
}) {
  assert(pageBuilderCallback != null || builderCallback != null);
  return GoRoute(
    parentNavigatorKey: parentNavigatorKey,
    path: pathCallback(depth),
    pageBuilder:
        pageBuilderCallback != null
            ? (context, state) => pageBuilderCallback(context, state, depth)
            : null,
    builder:
        builderCallback != null
            ? (context, state) => builderCallback(context, state, depth)
            : null,
    routes:
        depth == 1
            ? <RouteBase>[]
            : [
              _buildRoutesRecursively(
                depth: depth - 1,
                pathCallback: pathCallback,
                pageBuilderCallback: pageBuilderCallback,
                builderCallback: builderCallback,
                parentNavigatorKey: parentNavigatorKey,
              ),
            ],
  );
}
