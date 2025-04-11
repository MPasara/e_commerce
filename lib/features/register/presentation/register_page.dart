import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopzy/common/presentation/spacing.dart';
import 'package:shopzy/common/presentation/widgets/shopzy_button.dart';
import 'package:shopzy/features/auth/domain/notifiers/auth_notifier.dart';
import 'package:shopzy/features/login/presentation/widgets/shopzy_text_field.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class RegisterPage extends ConsumerStatefulWidget {
  static const routeName = '/register';

  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isFormValid = false;

  void _onFormChanged() {
    final emailValue = _formKey.currentState?.fields['email']?.value as String?;
    final passwordValue =
        _formKey.currentState?.fields['password']?.value as String?;
    final confirmPasswordValue =
        _formKey.currentState?.fields['confirm_password']?.value as String?;

    setState(() {
      _isFormValid =
          emailValue?.isNotEmpty == true &&
          passwordValue?.isNotEmpty == true &&
          confirmPasswordValue?.isNotEmpty == true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Icon(Icons.arrow_back_ios_new),
                      ),
                      spacing16,
                      Text(
                        'Register Account',
                        style: TextStyle(
                          color: Color(0xff0C1A30),
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                  spacing20,
                  Text(
                    'Enter Email and Password to register',
                    style: TextStyle(color: Color(0xff0C1A30)),
                  ),
                  spacing50,
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
                        spacing30,
                        Text('Confirm Password'),
                        spacing20,
                        ShopzyTextField.confirmPassword(),
                      ],
                    ),
                  ),
                  spacing70,
                  ShopzyButton.primary(
                    onPressed:
                        !_isFormValid
                            ? null
                            : () {
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
                                final confirmPassword =
                                    _formKey
                                            .currentState
                                            ?.fields['confirm_password']
                                            ?.value
                                        as String;

                                final passwordError = _validateConfirmPassword(
                                  confirmPassword,
                                );
                                if (passwordError != null) {
                                  _formKey
                                      .currentState
                                      ?.fields['confirm_password']
                                      ?.invalidate(passwordError);
                                  return;
                                }

                                ref
                                    .read(authNotifierProvider.notifier)
                                    .login(email: email, password: password);
                              }
                            },
                    text: 'Register',
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
                      colored: true,
                      socialButtonVariant: SocialButtonVariant.icon,

                      redirectUrl:
                          kIsWeb
                              ? null
                              : 'io.supabase.flutter://reset-callback/',
                      onSuccess: (Session response) {
                        // do something, for example: navigate('home');
                      },
                      onError: (error) {
                        // do something, for example: navigate("wait_for_email");
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }

    final password =
        _formKey.currentState?.fields['password']?.value as String?;
    if (password != value) {
      return 'Passwords do not match';
    }

    return null;
  }
}
