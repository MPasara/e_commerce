import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';
import 'package:shopzy/common/domain/router/navigation_extensions.dart';
import 'package:shopzy/common/presentation/spacing.dart';
import 'package:shopzy/common/presentation/widgets/shopzy_button.dart';
import 'package:shopzy/features/auth/domain/notifiers/auth_notifier.dart';
import 'package:shopzy/features/login/presentation/widgets/shopzy_text_field.dart';
import 'package:shopzy/features/register/presentation/register_page.dart';
import 'package:shopzy/features/reset_password/presentation/reset_password_page.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class LoginPage extends ConsumerStatefulWidget {
  static const routeName = '/login';

  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isFormValid = false;

  void _onFormChanged() {
    final emailValue = _formKey.currentState?.fields['email']?.value as String?;
    final passwordValue =
        _formKey.currentState?.fields['password']?.value as String?;

    setState(() {
      _isFormValid =
          emailValue?.isNotEmpty == true && passwordValue?.isNotEmpty == true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back to Shopzy',
                    style: TextStyle(color: Color(0xff0C1A30), fontSize: 25),
                  ),
                  spacing20,
                  Text(
                    'Please enter your login details',
                    style: TextStyle(color: Color(0xff838589)),
                  ),
                  spacing70,
                  FormBuilder(
                    key: _formKey,
                    onChanged: _onFormChanged,
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
                  spacing70,

                  ShopzyButton.primary(
                    onPressed:
                        !_isFormValid
                            ? null
                            : () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (_formKey.currentState?.saveAndValidate() ??
                                  false) {
                                final email =
                                    _formKey
                                            .currentState
                                            ?.fields['email']
                                            ?.value
                                        as String;
                                final password =
                                    _formKey
                                            .currentState
                                            ?.fields['password']
                                            ?.value
                                        as String;

                                ref
                                    .read(authNotifierProvider.notifier)
                                    .login(email: email, password: password);
                              }
                            },
                    text: 'Sign in',
                  ),
                  spacing16,
                  Row(
                    children: [
                      Expanded(child: Divider(color: Color(0xffE5E5E5))),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'OR',
                          style: TextStyle(
                            color: Color(0xff838589),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Expanded(child: Divider(color: Color(0xffE5E5E5))),
                    ],
                  ),
                  spacing16,
                  Center(
                    child: SupaSocialsAuth(
                      socialProviders: [
                        OAuthProvider.google,
                        if (Platform.isIOS) OAuthProvider.apple,
                      ],
                      showSuccessSnackBar: false,
                      colored: true,
                      socialButtonVariant: SocialButtonVariant.icon,
                      redirectUrl:
                          kIsWeb
                              ? null
                              : 'io.supabase.flutter://login-callback/',
                      onSuccess:
                          (_) =>
                              ref
                                  .read(authNotifierProvider.notifier)
                                  .socialLogin(),
                      onError: (error) {
                        logDebug('sign-in error: $error');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    ref.pushNamed(
                      '${LoginPage.routeName}${ResetPasswordPage.routeName}',
                    );
                  },
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(color: Color(0xff0C1A30)),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    ref.pushNamed(
                      '${LoginPage.routeName}${RegisterPage.routeName}',
                    );
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
      ),
    );
  }
}
