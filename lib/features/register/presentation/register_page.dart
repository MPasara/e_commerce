import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopzy/common/data/services/database_service.dart';
import 'package:shopzy/common/presentation/spacing.dart';
import 'package:shopzy/common/presentation/widgets/shopzy_button.dart';
import 'package:shopzy/features/auth/domain/notifiers/auth_notifier.dart';
import 'package:shopzy/features/login/presentation/widgets/shopzy_text_field.dart';

class RegisterPage extends ConsumerStatefulWidget {
  static const routeName = '/register';

  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isFormValid = false;
  bool _isProcessing = false;

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

  Future<void> _handleGoogleSignUp() async {
    if (_isProcessing) return;

    setState(() => _isProcessing = true);
    try {
      await ref
          .read(authNotifierProvider.notifier)
          .socialSignUp(provider: AuthProvider.google);
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  Future<void> _handleAppleSignUp() async {
    if (_isProcessing) return;

    setState(() => _isProcessing = true);
    try {
      await ref
          .read(authNotifierProvider.notifier)
          .socialSignUp(provider: AuthProvider.apple);
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
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
                        !_isFormValid || _isProcessing
                            ? null
                            : () async {
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
                                  final confirmPassword =
                                      _formKey
                                              .currentState
                                              ?.fields['confirm_password']
                                              ?.value
                                          as String;

                                  final passwordError =
                                      _validateConfirmPassword(confirmPassword);
                                  if (passwordError != null) {
                                    _formKey
                                        .currentState
                                        ?.fields['confirm_password']
                                        ?.invalidate(passwordError);
                                    setState(() => _isProcessing = false);
                                    return;
                                  }

                                  await ref
                                      .read(authNotifierProvider.notifier)
                                      .signUp(email: email, password: password);
                                } finally {
                                  if (mounted) {
                                    setState(() => _isProcessing = false);
                                  }
                                }
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          icon: Icon(Icons.g_mobiledata),
                          label: Text('Google'),
                          onPressed: _isProcessing ? null : _handleGoogleSignUp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                          ),
                        ),
                        spacing16,

                        if (Platform.isIOS)
                          ElevatedButton.icon(
                            icon: Icon(Icons.apple),
                            label: Text('Apple'),
                            onPressed:
                                _isProcessing ? null : _handleAppleSignUp,
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
