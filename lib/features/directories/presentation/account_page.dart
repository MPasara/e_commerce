import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopzy/common/domain/router/navigation_extensions.dart';
import 'package:shopzy/common/presentation/build_context_extensions.dart';
import 'package:shopzy/common/presentation/spacing.dart';
import 'package:shopzy/features/auth/domain/notifiers/auth_notifier.dart';

class AccountPage extends ConsumerWidget {
  static const routeName = '/account';
  static String pathPattern(int level) => ':directoryName$level';

  const AccountPage({super.key, this.directoryName, this.canGoDeeper = true});

  final String? directoryName;
  final bool canGoDeeper;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        if (directoryName != null) ...[
          TextButton(
            onPressed: ref.pop,
            child: Text('Go back', style: context.appTextStyles.regular),
          ),
          spacing16,
        ],
        Text(
          'Account: $directoryName',
          style: context.appTextStyles.boldLarge,
          textAlign: TextAlign.center,
        ),
        if (canGoDeeper) ...[
          spacing16,
          TextButton(
            onPressed:
                () => ref.pushNamed(
                  ref.getRouteNameFromCurrentLocation(
                    '/${Random().nextInt(100)}',
                  ),
                ),
            child: Text(
              'Open child directory',
              style: context.appTextStyles.regular,
            ),
          ),
        ],
        spacing16,
        TextButton(
          onPressed: ref.read(authNotifierProvider.notifier).logout,
          child: Text('Logout', style: context.appTextStyles.regular),
        ),
        spacing16,
      ],
    );
  }
}
