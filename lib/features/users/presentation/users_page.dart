import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:shopzy/common/domain/router/navigation_extensions.dart';
import 'package:shopzy/common/presentation/build_context_extensions.dart';
import 'package:shopzy/common/presentation/spacing.dart';
import 'package:shopzy/features/users/presentation/user_details_page.dart';

class UsersPage extends ConsumerWidget {
  static const routeName = '/users';

  const UsersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        Text(
          'Users',
          style: context.appTextStyles.boldLarge,
          textAlign: TextAlign.center,
        ),
        spacing16,
        TextButton(
          onPressed:
              () => ref.pushNamed(
                ref.getRouteNameFromCurrentLocation(
                  UserDetailsPage.getRouteNameWithParams(1, optional: 'abc'),
                ),
              ),
          child: Text('User 1', style: context.appTextStyles.bold),
        ),
        spacing16,
        TextButton(
          onPressed:
              () => ref.pushNamed(
                ref.getRouteNameFromCurrentLocation(
                  UserDetailsPage.getRouteNameWithParams(2),
                  keepExistingQueryString: false,
                ),
              ),
          child: Text('User 2', style: context.appTextStyles.bold),
        ),
        spacing16,
        TextButton(
          onPressed:
              () => ref.pushNamed(
                '${UsersPage.routeName}${UserDetailsPage.routeName.replaceAll(UserDetailsPage.pathPattern, 'R')}',
              ),
          child: Text('User R', style: context.appTextStyles.bold),
        ),
      ],
    );
  }
}
