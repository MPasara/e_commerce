import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopzy/common/domain/router/navigation_extensions.dart';
import 'package:shopzy/common/presentation/build_context_extensions.dart';
import 'package:shopzy/common/presentation/form_builder_keys.dart';
import 'package:shopzy/common/presentation/spacing.dart';
import 'package:shopzy/common/presentation/widgets/shopzy_button.dart';
import 'package:shopzy/features/auth/domain/notifiers/auth_notifier.dart';
import 'package:shopzy/features/login/presentation/widgets/shopzy_text_field.dart';
import 'package:shopzy/features/register/presentation/register_page.dart';
import 'package:shopzy/features/reset_password/presentation/reset_password_page.dart';
import 'package:shopzy/generated/l10n.dart';
import 'package:shopzy/theme/app_colors.dart';

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
    final formState = _formKey.currentState;
    if (formState == null) return;

    setState(() {
      formState.save();
      _isFormValid = formState.isValid;
    });
  }

  Future<void> _handleLogin() async {
    final formState = _formKey.currentState;
    if (formState == null || !formState.saveAndValidate()) return;

    FocusManager.instance.primaryFocus?.unfocus();

    final formData = formState.value;
    await ref
        .read(authNotifierProvider.notifier)
        .login(
          email: formData[FormBuilderKeys.email],
          password: formData[FormBuilderKeys.password],
        );
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();

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
                    style: context.appTextStyles.title,
                  ),
                  spacing20,
                  Text(
                    S.current.loginSubtitle,
                    style: context.appTextStyles.subtitle,
                  ),
                  spacing70,
                  FormBuilder(
                    key: _formKey,
                    onChanged: _onFormChanged,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.current.emailLabel,
                          style: context.appTextStyles.label,
                        ),
                        spacing20,
                        ShopzyTextField.email(),
                        spacing30,
                        Text(
                          S.current.passwordLabel,
                          style: context.appTextStyles.label,
                        ),
                        spacing20,
                        ShopzyTextField.password(),
                      ],
                    ),
                  ),
                  spacing70,

                  ShopzyButton.primary(
                    onPressed: !_isFormValid ? null : _handleLogin,
                    text: S.current.signInButton,
                  ),
                  spacing16,
                  Row(
                    children: [
                      Expanded(child: Divider(color: appColors?.labelGrey)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          S.current.orDivider,
                          style: context.appTextStyles.divider,
                        ),
                      ),
                      Expanded(child: Divider(color: appColors?.labelGrey)),
                    ],
                  ),
                  spacing16,
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          icon: Icon(
                            Icons.g_mobiledata,
                            color: appColors?.black,
                          ),
                          label: Text(
                            S.current.googleSignIn,
                            style: context.appTextStyles.button?.copyWith(
                              color: appColors?.black,
                            ),
                          ),
                          onPressed: () async {
                            await ref
                                .read(authNotifierProvider.notifier)
                                .socialLogin(isApple: false);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appColors?.defaultColor,
                            foregroundColor: appColors?.defaultColor,
                          ),
                        ),
                        spacing16,

                        if (Platform.isIOS)
                          ElevatedButton.icon(
                            icon: Icon(
                              Icons.apple,
                              color: appColors?.background,
                            ),
                            label: Text(
                              S.current.appleSignIn,
                              style: context.appTextStyles.button?.copyWith(
                                color: appColors?.background,
                              ),
                            ),
                            onPressed: () async {
                              await ref
                                  .read(authNotifierProvider.notifier)
                                  .socialLogin(isApple: true);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: appColors?.secondary,
                              foregroundColor: appColors?.background,
                            ),
                          ),
                      ],
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
                    S.current.forgotPassword,
                    style: context.appTextStyles.linkPrimary,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    ref.pushNamed(
                      '${LoginPage.routeName}${RegisterPage.routeName}',
                    );
                  },
                  child: Text(
                    S.current.signUp,
                    style: context.appTextStyles.linkPrimary,
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
