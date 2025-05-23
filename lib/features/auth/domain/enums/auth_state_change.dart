import 'package:supabase_flutter/supabase_flutter.dart';

enum AuthStateChange {
  signedIn,
  signedOut,
  tokenRefreshed,
  userUpdated,
  passwordRecovery,
  unknown;

  static AuthStateChange fromSupabaseEvent(AuthChangeEvent event) {
    return switch (event) {
      AuthChangeEvent.signedIn => AuthStateChange.signedIn,
      AuthChangeEvent.signedOut => AuthStateChange.signedOut,
      AuthChangeEvent.tokenRefreshed => AuthStateChange.tokenRefreshed,
      AuthChangeEvent.userUpdated => AuthStateChange.userUpdated,
      AuthChangeEvent.passwordRecovery => AuthStateChange.passwordRecovery,
      _ => AuthStateChange.unknown,
    };
  }
}
