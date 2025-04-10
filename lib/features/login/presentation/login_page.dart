import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopzy/common/domain/router/navigation_extensions.dart';
import 'package:shopzy/common/presentation/spacing.dart';
import 'package:shopzy/common/presentation/widgets/shopyz_button.dart';
import 'package:shopzy/features/auth/domain/notifiers/auth_notifier.dart';
import 'package:shopzy/features/login/presentation/widgets/shopzy_text_field.dart';
import 'package:shopzy/features/register/presentation/register_page.dart';
import 'package:shopzy/features/reset_password/presentation/reset_password_page.dart';

class LoginPage extends ConsumerWidget {
  static const routeName = '/login';

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, top: 16, right: 25),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back to Shopzy',
                    style: TextStyle(color: Color(0xff0C1A30), fontSize: 25),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Please enter your login details',
                    style: TextStyle(color: Color(0xff838589)),
                  ),
                  spacing50,
                  FormBuilder(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email'),
                        spacing20,
                        ShopzyTextField.email(),
                        spacing30,
                        Text('Password'),
                        spacing20,
                        ShopzyTextField.password(),
                      ],
                    ),
                  ),
                  ShopzyButton.primary(
                    onPressed: () {
                      if (formKey.currentState?.saveAndValidate() ?? false) {
                        final email =
                            formKey.currentState?.fields['email']?.value
                                as String;
                        final password =
                            formKey.currentState?.fields['password']?.value
                                as String;

                        ref
                            .read(authNotifierProvider.notifier)
                            .login(email: email, password: password);
                      }
                    },
                    text: 'Sign in',
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  ref.pushNamed('$routeName${ResetPasswordPage.routeName}');
                },
                child: Text(
                  'Forgot Password',
                  style: TextStyle(color: Color(0xff0C1A30)),
                ),
              ),
              TextButton(
                onPressed: () {
                  ref.pushNamed('$routeName${RegisterPage.routeName}');
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(color: Color(0xff3669C9)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
