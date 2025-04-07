import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:shopzy/common/domain/router/navigation_extensions.dart';
import 'package:shopzy/common/presentation/spacing.dart';
import 'package:shopzy/common/presentation/widgets/version_number_widget.dart';
import 'package:shopzy/features/auth/domain/notifiers/auth_notifier.dart';
import 'package:shopzy/features/register/presentation/register_page.dart';
import 'package:shopzy/features/reset_password/presentation/reset_password_page.dart';

class LoginPage extends ConsumerWidget {
  static const routeName = '/login';

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: ListView(
        children: [
          TextButton(
            onPressed:
                () => ref
                    .read(authNotifierProvider.notifier)
                    .login(email: 'email', password: 'password'),
            child: Text('Login'),
          ),
          spacing16,
          TextButton(
            onPressed:
                () => ref.pushNamed('$routeName${ResetPasswordPage.routeName}'),
            child: Text('Reset Password'),
          ),
          spacing16,
          TextButton(
            onPressed:
                () => ref.pushNamed('$routeName${RegisterPage.routeName}'),
            child: Text('Register'),
          ),
          spacing16,
          Center(child: VersionNumberWidget()),
        ],
      ),
    );
  }
}
