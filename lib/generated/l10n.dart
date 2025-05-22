// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `example@email.com`
  String get emailHint {
    return Intl.message(
      'example@email.com',
      name: 'emailHint',
      desc: '',
      args: [],
    );
  }

  /// `Enter account password`
  String get passwordHint {
    return Intl.message(
      'Enter account password',
      name: 'passwordHint',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirmPasswordHint {
    return Intl.message(
      'Confirm password',
      name: 'confirmPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get passwordValidationError {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'passwordValidationError',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back to Shopzy`
  String get loginWelcomeTitle {
    return Intl.message(
      'Welcome back to Shopzy',
      name: 'loginWelcomeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your login details`
  String get loginSubtitle {
    return Intl.message(
      'Please enter your login details',
      name: 'loginSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailLabel {
    return Intl.message(
      'Email',
      name: 'emailLabel',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordLabel {
    return Intl.message(
      'Password',
      name: 'passwordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get signInButton {
    return Intl.message(
      'Sign in',
      name: 'signInButton',
      desc: '',
      args: [],
    );
  }

  /// `OR`
  String get orDivider {
    return Intl.message(
      'OR',
      name: 'orDivider',
      desc: '',
      args: [],
    );
  }

  /// `Google`
  String get googleSignIn {
    return Intl.message(
      'Google',
      name: 'googleSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Apple`
  String get appleSignIn {
    return Intl.message(
      'Apple',
      name: 'appleSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Register Account`
  String get registerTitle {
    return Intl.message(
      'Register Account',
      name: 'registerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter Email and Password to register`
  String get registerSubtitle {
    return Intl.message(
      'Enter Email and Password to register',
      name: 'registerSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPasswordLabel {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get registerButton {
    return Intl.message(
      'Register',
      name: 'registerButton',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get requiredFieldError {
    return Intl.message(
      'This field is required',
      name: 'requiredFieldError',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Login failed: No session created`
  String get loginFailed {
    return Intl.message(
      'Login failed: No session created',
      name: 'loginFailed',
      desc: '',
      args: [],
    );
  }

  /// `Sign up failed: No session created`
  String get signUpFailed {
    return Intl.message(
      'Sign up failed: No session created',
      name: 'signUpFailed',
      desc: '',
      args: [],
    );
  }

  /// `Social sign-in failed`
  String get socialSignInFailed {
    return Intl.message(
      'Social sign-in failed',
      name: 'socialSignInFailed',
      desc: '',
      args: [],
    );
  }

  /// `Could not find ID Token from generated credential.`
  String get appleIdTokenNotFound {
    return Intl.message(
      'Could not find ID Token from generated credential.',
      name: 'appleIdTokenNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Google sign in was cancelled by the user.`
  String get googleSignInCancelled {
    return Intl.message(
      'Google sign in was cancelled by the user.',
      name: 'googleSignInCancelled',
      desc: '',
      args: [],
    );
  }

  /// `No Access Token found.`
  String get googleAccessTokenNotFound {
    return Intl.message(
      'No Access Token found.',
      name: 'googleAccessTokenNotFound',
      desc: '',
      args: [],
    );
  }

  /// `No ID Token found.`
  String get googleIdTokenNotFound {
    return Intl.message(
      'No ID Token found.',
      name: 'googleIdTokenNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Failed to sign out: {error}`
  String signOutFailed(Object error) {
    return Intl.message(
      'Failed to sign out: $error',
      name: 'signOutFailed',
      desc: '',
      args: [error],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'hr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
