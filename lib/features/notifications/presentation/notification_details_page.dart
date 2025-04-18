import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:shopzy/common/presentation/build_context_extensions.dart';

class NotificationDetailsPage extends ConsumerWidget {
  static const routeName = '/$pathPattern';
  static const pathPattern = ':notificationId';

  static String getRouteNameWithParams(int notificationId) =>
      routeName.replaceAll(pathPattern, '$notificationId');

  const NotificationDetailsPage({super.key, required this.notificationId});

  final int notificationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Notification details')),
      body: ListView(
        children: [
          Text(
            'Notification id: $notificationId',
            style: context.appTextStyles.boldLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
