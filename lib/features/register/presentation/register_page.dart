import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopzy/common/presentation/build_context_extensions.dart';
import 'package:shopzy/common/presentation/form_builder_keys.dart';
import 'package:shopzy/common/presentation/spacing.dart';
import 'package:shopzy/common/presentation/widgets/shopzy_button.dart';
import 'package:shopzy/features/auth/domain/notifiers/auth_notifier.dart';
import 'package:shopzy/features/login/presentation/widgets/shopzy_text_field.dart';
import 'package:shopzy/generated/l10n.dart';
import 'package:shopzy/theme/app_colors.dart';

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
    final formState = _formKey.currentState;
    if (formState == null) return;

    setState(() {
      formState.save();
      _isFormValid = formState.isValid;
    });
  }

  Future<void> _handleRegister() async {
    final formState = _formKey.currentState;
    if (formState == null || !formState.saveAndValidate()) return;

    FocusManager.instance.primaryFocus?.unfocus();

    final formData = formState.value;
    await ref
        .read(authNotifierProvider.notifier)
        .signUp(
          email: formData[FormBuilderKeys.email] as String,
          password: formData[FormBuilderKeys.password] as String,
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
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: appColors?.secondary,
                        ),
                      ),
                      spacing16,
                      Text(
                        S.current.registerTitle,
                        style: context.appTextStyles.title,
                      ),
                    ],
                  ),
                  spacing20,
                  Text(
                    S.current.registerSubtitle,
                    style: context.appTextStyles.subtitle,
                  ),
                  spacing50,
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
                        spacing30,
                        Text(
                          S.current.confirmPasswordLabel,
                          style: context.appTextStyles.label,
                        ),
                        spacing20,
                        ShopzyTextField.confirmPassword(
                          (value) =>
                              value ==
                                      _formKey
                                          .currentState
                                          ?.fields[FormBuilderKeys.password]
                                          ?.value
                                  ? null
                                  : S.current.passwordsDoNotMatch,
                        ),
                      ],
                    ),
                  ),
                  spacing70,
                  ShopzyButton.primary(
                    onPressed: !_isFormValid ? null : _handleRegister,
                    text: S.current.registerButton,
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
                          onPressed: () {
                            ref
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
                            onPressed: () {
                              ref
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
      ),
    );
  }
}
