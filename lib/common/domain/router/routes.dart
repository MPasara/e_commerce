
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:shopzy/example/example_routes.dart';
import 'package:shopzy/features/dashboard/presentation/dashboard_page.dart';
import 'package:shopzy/features/directories/presentation/directories_page.dart';
import 'package:shopzy/features/home/presentation/home_page.dart';
import 'package:shopzy/features/login/presentation/login_page.dart';
import 'package:shopzy/features/notifications/presentation/all_notifications_page.dart';
import 'package:shopzy/features/notifications/presentation/notification_details_page.dart';
import 'package:shopzy/features/notifications/presentation/notifications_page.dart';
import 'package:shopzy/features/register/presentation/register_page.dart';
import 'package:shopzy/features/reset_password/presentation/reset_password_page.dart';
import 'package:shopzy/features/users/presentation/user_details_page.dart';
import 'package:shopzy/features/users/presentation/users_page.dart';
import 'package:shopzy/common/domain/utils/string_extensions.dart';
import 'package:shopzy/common/domain/router/go_router_state_extensions.dart';

List<RouteBase> getRoutes({
  required GlobalKey<NavigatorState> rootNavigatorKey,
  bool stateful = true,
}) => [
  GoRoute(
    path: HomePage.routeName,
    redirect: (context, state) => DashboardPage.routeName,
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
          HomePage(navigationShell: navigationShell),
  branches: [
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: DashboardPage.routeName,
          builder: (context, state) => DashboardPage(),
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
                    redirectTo: DashboardPage.routeName,
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
          path: UsersPage.routeName,
          builder: (context, state) => UsersPage(),
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
                    redirectTo: UsersPage.routeName,
                  ),
            ),
          ],
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: NotificationsPage.routeName,
          builder: (context, state) => NotificationsPage(),
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
                            '${NotificationsPage.routeName}${AllNotificationsPage.routeName}',
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
                    redirectTo: NotificationsPage.routeName,
                  ),
            ),
          ],
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: DirectoriesPage.routeName,
          builder: (context, state) => DirectoriesPage(),
          routes: [
            _buildRoutesRecursively(
              depth: 10,
              pathCallback: (depth) => DirectoriesPage.pathPattern(depth),
              builderCallback:
                  (context, state, depth) => DirectoriesPage(
                    directoryName:
                        state.pathParameters[DirectoriesPage.pathPattern(
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
  builder: (context, state, child) => HomePage(child: child),
  routes: [
    GoRoute(
      path: DashboardPage.routeName,
      builder: (context, state) => DashboardPage(),
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
                redirectTo: DashboardPage.routeName,
              ),
        ),
      ],
    ),
    GoRoute(
      path: UsersPage.routeName,
      builder: (context, state) => UsersPage(),
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
                redirectTo: UsersPage.routeName,
              ),
        ),
      ],
    ),
    GoRoute(
      path: NotificationsPage.routeName,
      builder: (context, state) => NotificationsPage(),
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
                        '${NotificationsPage.routeName}${AllNotificationsPage.routeName}',
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
                redirectTo: NotificationsPage.routeName,
              ),
        ),
      ],
    ),
    GoRoute(
      path: DirectoriesPage.routeName,
      builder: (context, state) => DirectoriesPage(),
      routes: [
        _buildRoutesRecursively(
          depth: 10,
          pathCallback: (depth) => DirectoriesPage.pathPattern(depth),
          builderCallback:
              (context, state, depth) => DirectoriesPage(
                directoryName:
                    state.pathParameters[DirectoriesPage.pathPattern(
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
