// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(error) => "Failed to sign out: ${error}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appleIdTokenNotFound": MessageLookupByLibrary.simpleMessage(
            "Could not find ID Token from generated credential."),
        "appleSignIn": MessageLookupByLibrary.simpleMessage("Apple"),
        "authSuccess":
            MessageLookupByLibrary.simpleMessage("Successfully authenticated"),
        "confirmPasswordHint":
            MessageLookupByLibrary.simpleMessage("Confirm password"),
        "confirmPasswordLabel":
            MessageLookupByLibrary.simpleMessage("Confirm Password"),
        "emailHint": MessageLookupByLibrary.simpleMessage("example@email.com"),
        "emailLabel": MessageLookupByLibrary.simpleMessage("Email"),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("Forgot Password"),
        "googleAccessTokenNotFound":
            MessageLookupByLibrary.simpleMessage("No Access Token found."),
        "googleIdTokenNotFound":
            MessageLookupByLibrary.simpleMessage("No ID Token found."),
        "googleSignIn": MessageLookupByLibrary.simpleMessage("Google"),
        "googleSignInCancelled": MessageLookupByLibrary.simpleMessage(
            "Google sign in was cancelled by the user."),
        "loginFailed": MessageLookupByLibrary.simpleMessage(
            "Login failed: No session created"),
        "loginSubtitle": MessageLookupByLibrary.simpleMessage(
            "Please enter your login details"),
        "loginWelcomeTitle":
            MessageLookupByLibrary.simpleMessage("Welcome back to Shopzy"),
        "logoutSuccess":
            MessageLookupByLibrary.simpleMessage("Successfully logged out"),
        "orDivider": MessageLookupByLibrary.simpleMessage("OR"),
        "passwordHint":
            MessageLookupByLibrary.simpleMessage("Enter account password"),
        "passwordLabel": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordValidationError": MessageLookupByLibrary.simpleMessage(
            "Password must be at least 6 characters"),
        "passwordsDoNotMatch":
            MessageLookupByLibrary.simpleMessage("Passwords do not match"),
        "registerButton": MessageLookupByLibrary.simpleMessage("Register"),
        "registerSubtitle": MessageLookupByLibrary.simpleMessage(
            "Enter Email and Password to register"),
        "registerTitle":
            MessageLookupByLibrary.simpleMessage("Register Account"),
        "requiredFieldError":
            MessageLookupByLibrary.simpleMessage("This field is required"),
        "signInButton": MessageLookupByLibrary.simpleMessage("Sign in"),
        "signOutFailed": m0,
        "signUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
        "signUpFailed": MessageLookupByLibrary.simpleMessage(
            "Sign up failed: No session created"),
        "sign_up_failed":
            MessageLookupByLibrary.simpleMessage("Sign up failed"),
        "sign_up_success":
            MessageLookupByLibrary.simpleMessage("Signed up successfully"),
        "socialSignInFailed":
            MessageLookupByLibrary.simpleMessage("Social sign-in failed")
      };
}
