import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopzy/common/domain/router/navigation_extensions.dart';
import 'package:shopzy/common/presentation/spacing.dart';
import 'package:shopzy/common/presentation/widgets/shopzy_button.dart';
import 'package:shopzy/features/auth/domain/notifiers/auth_notifier.dart';
import 'package:shopzy/features/login/presentation/widgets/shopzy_text_field.dart';
import 'package:shopzy/features/register/presentation/register_page.dart';
import 'package:shopzy/features/reset_password/presentation/reset_password_page.dart';
import 'package:shopzy/generated/l10n.dart';

class LoginPage extends ConsumerStatefulWidget {
  static const routeName = '/login';

  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isFormValid = false;
  bool _isProcessing = false;

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
                    S.current.loginWelcomeTitle,
                    style: TextStyle(color: Color(0xff0C1A30), fontSize: 25),
                  ),
                  spacing20,
                  Text(
                    S.current.loginSubtitle,
                    style: TextStyle(color: Color(0xff838589)),
                  ),
                  spacing70,
                  FormBuilder(
                    key: _formKey,
                    onChanged: _onFormChanged,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(S.current.emailLabel),
                        spacing20,
                        ShopzyTextField.email(),
                        spacing30,
                        Text(S.current.passwordLabel),
                        spacing20,
                        ShopzyTextField.password(),
                      ],
                    ),
                  ),
                  spacing70,

                  ShopzyButton.primary(
                    onPressed:
                        !_isFormValid || _isProcessing
                            ? null
                            : () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (_formKey.currentState?.saveAndValidate() ??
                                  false) {
                                setState(() => _isProcessing = true);

                                try {
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

                                  await ref
                                      .read(authNotifierProvider.notifier)
                                      .login(email: email, password: password);
                                } finally {
                                  if (mounted) {
                                    setState(() => _isProcessing = false);
                                  }
                                }
                              }
                            },
                    text: S.current.signInButton,
                  ),
                  spacing16,
                  Row(
                    children: [
                      Expanded(child: Divider(color: Color(0xffE5E5E5))),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          S.current.orDivider,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          icon: Icon(Icons.g_mobiledata),
                          label: Text(S.current.googleSignIn),
                          onPressed: () {
                            ref
                                .read(authNotifierProvider.notifier)
                                .googleLogin();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                          ),
                        ),
                        spacing16,

                        if (Platform.isIOS)
                          ElevatedButton.icon(
                            icon: Icon(Icons.apple),
                            label: Text(S.current.appleSignIn),
                            onPressed: () async {
                              await ref
                                  .read(authNotifierProvider.notifier)
                                  .appleLogin();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (_isProcessing)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Center(child: CircularProgressIndicator()),
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
                  onPressed:
                      _isProcessing
                          ? null
                          : () {
                            ref.pushNamed(
                              '${LoginPage.routeName}${ResetPasswordPage.routeName}',
                            );
                          },
                  child: Text(
                    S.current.forgotPassword,
                    style: TextStyle(color: Color(0xff0C1A30)),
                  ),
                ),
                TextButton(
                  onPressed:
                      _isProcessing
                          ? null
                          : () {
                            ref.pushNamed(
                              '${LoginPage.routeName}${RegisterPage.routeName}',
                            );
                          },
                  child: Text(
                    S.current.signUp,
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
