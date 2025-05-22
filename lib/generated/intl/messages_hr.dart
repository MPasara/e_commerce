// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a hr locale. All the
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
  String get localeName => 'hr';

  static String m0(error) => "Odjava nije uspjela: ${error}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appleIdTokenNotFound": MessageLookupByLibrary.simpleMessage(
            "ID token nije pronađen iz generiranih vjerodajnica."),
        "appleSignIn": MessageLookupByLibrary.simpleMessage("Apple"),
        "confirmPasswordHint":
            MessageLookupByLibrary.simpleMessage("Potvrdite lozinku"),
        "confirmPasswordLabel":
            MessageLookupByLibrary.simpleMessage("Potvrdite lozinku"),
        "emailHint": MessageLookupByLibrary.simpleMessage("primjer@email.com"),
        "emailLabel": MessageLookupByLibrary.simpleMessage("E-pošta"),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("Zaboravljena lozinka"),
        "googleAccessTokenNotFound": MessageLookupByLibrary.simpleMessage(
            "Token za pristup nije pronađen."),
        "googleIdTokenNotFound":
            MessageLookupByLibrary.simpleMessage("ID token nije pronađen."),
        "googleSignIn": MessageLookupByLibrary.simpleMessage("Google"),
        "googleSignInCancelled": MessageLookupByLibrary.simpleMessage(
            "Google prijava je otkazana od strane korisnika."),
        "loginFailed": MessageLookupByLibrary.simpleMessage(
            "Prijava nije uspjela: Sesija nije kreirana"),
        "loginSubtitle": MessageLookupByLibrary.simpleMessage(
            "Molimo unesite svoje podatke za prijavu"),
        "loginWelcomeTitle":
            MessageLookupByLibrary.simpleMessage("Dobrodošli natrag u Shopzy"),
        "orDivider": MessageLookupByLibrary.simpleMessage("ILI"),
        "passwordHint":
            MessageLookupByLibrary.simpleMessage("Unesite lozinku računa"),
        "passwordLabel": MessageLookupByLibrary.simpleMessage("Lozinka"),
        "passwordValidationError": MessageLookupByLibrary.simpleMessage(
            "Lozinka mora imati najmanje 6 znakova"),
        "passwordsDoNotMatch":
            MessageLookupByLibrary.simpleMessage("Lozinke se ne podudaraju"),
        "registerButton":
            MessageLookupByLibrary.simpleMessage("Registriraj se"),
        "registerSubtitle": MessageLookupByLibrary.simpleMessage(
            "Unesite e-poštu i lozinku za registraciju"),
        "registerTitle":
            MessageLookupByLibrary.simpleMessage("Registracija računa"),
        "requiredFieldError":
            MessageLookupByLibrary.simpleMessage("Ovo polje je obavezno"),
        "signInButton": MessageLookupByLibrary.simpleMessage("Prijavi se"),
        "signOutFailed": m0,
        "signUp": MessageLookupByLibrary.simpleMessage("Registriraj se"),
        "signUpFailed": MessageLookupByLibrary.simpleMessage(
            "Registracija nije uspjela: Sesija nije kreirana"),
        "socialSignInFailed": MessageLookupByLibrary.simpleMessage(
            "Društvena prijava nije uspjela")
      };
}
