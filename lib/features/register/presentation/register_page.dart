import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:shopzy/common/domain/router/navigation_extensions.dart';

class RegisterPage extends ConsumerWidget {
  static const routeName = '/register';

  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: ListView(
        children: [TextButton(onPressed: ref.pop, child: Text('Go back'))],
      ),
    );
  }
}
