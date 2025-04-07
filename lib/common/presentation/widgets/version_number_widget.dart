
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:shopzy/common/data/services/package_info_service.dart';

final _versionNumberProvider = FutureProvider<String?>(
  (ref) => ref.watch(packageInfoServiceProvider).getVersionNumber(),
);

class VersionNumberWidget extends ConsumerWidget {
  const VersionNumberWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final versionNumberState = ref.watch(_versionNumberProvider);
    return versionNumberState.maybeWhen(
      orElse: () => SizedBox(),
      data: (versionNumber) => Text(versionNumber ?? ''),
    );
  }
}
