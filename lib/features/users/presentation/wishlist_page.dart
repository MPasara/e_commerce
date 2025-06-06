import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopzy/common/domain/router/navigation_extensions.dart';
import 'package:shopzy/common/presentation/build_context_extensions.dart';
import 'package:shopzy/common/presentation/spacing.dart';
import 'package:shopzy/features/users/presentation/user_details_page.dart';

class WishlistPage extends ConsumerWidget {
  static const routeName = '/wishlist';

  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        Text(
          'Wishlist'.toUpperCase(),
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
          child: Text('Item 1', style: context.appTextStyles.regular),
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
          child: Text('Item 2', style: context.appTextStyles.regular),
        ),
        spacing16,
        TextButton(
          onPressed:
              () => ref.pushNamed(
                '${WishlistPage.routeName}${UserDetailsPage.routeName.replaceAll(UserDetailsPage.pathPattern, 'R')}',
              ),
          child: Text('Item R', style: context.appTextStyles.regular),
        ),
      ],
    );
  }
}
