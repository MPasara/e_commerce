import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:shopzy/common/domain/providers/base_router_provider.dart';
import 'package:shopzy/common/domain/router/navigation_extensions.dart';
import 'package:shopzy/common/presentation/build_context_extensions.dart';
import 'package:shopzy/common/presentation/spacing.dart';
import 'package:shopzy/common/utils/q_logger.dart';
import 'package:shopzy/example/presentation/pages/example_page.dart';
import 'package:shopzy/main/app_environment.dart';
import 'package:shopzy/features/auth/domain/notifiers/auth_notifier.dart';
import 'package:shopzy/features/users/presentation/user_details_page.dart';
import 'package:shopzy/features/users/presentation/users_page.dart';

class DashboardPage extends ConsumerWidget {
  static const routeName = '/dashboard';

  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        Text(
          'Dashboard',
          style: context.appTextStyles.boldLarge,
          textAlign: TextAlign.center,
        ),
        spacing16,
        TextButton(
          onPressed: ref.read(authNotifierProvider.notifier).logout,
          child: Text('Logout', style: context.appTextStyles.regular),
        ),
        spacing16,
        TextButton(
          onPressed:
              () => ref.pushNamed(
                ref.getRouteNameFromCurrentLocation(ExamplePage.routeName),
              ),
          child: Text('Go to example page', style: context.appTextStyles.bold),
        ),
        spacing16,
        TextButton(
          onPressed:
              () => ref.pushNamed(
                ref.getRouteNameFromCurrentLocation(
                  UserDetailsPage.getRouteNameWithParams(1),
                ),
              ),
          child: Text(
            'Dashboard -> User details 1',
            style: context.appTextStyles.bold,
          ),
        ),
        spacing16,
        TextButton(
          onPressed:
              () => ref.pushNamed(
                '${UsersPage.routeName}${UserDetailsPage.getRouteNameWithParams(1)}',
              ),
          child: Text(
            'Users -> User details 1',
            style: context.appTextStyles.bold,
          ),
        ),
        if (!EnvInfo.isProduction) ...[
          spacing16,
          TextButton(
            onPressed:
                () => QLogger.showLogger(
                  ref.read(baseRouterProvider).navigatorContext!,
                ),
            child: Text('Show log report', style: context.appTextStyles.bold),
          ),
        ],
      ],
    );
  }
}
