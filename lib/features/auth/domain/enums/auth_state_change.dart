enum AuthStateChange {
  signedIn,
  signedOut,
  tokenRefreshed,
  userUpdated,
  userDeleted,
  passwordRecovery,
  unknown;

  static AuthStateChange fromSupabaseEvent(String event) {
    return switch (event) {
      'SIGNED_IN' => AuthStateChange.signedIn,
      'SIGNED_OUT' => AuthStateChange.signedOut,
      'TOKEN_REFRESHED' => AuthStateChange.tokenRefreshed,
      'USER_UPDATED' => AuthStateChange.userUpdated,
      'USER_DELETED' => AuthStateChange.userDeleted,
      'PASSWORD_RECOVERY' => AuthStateChange.passwordRecovery,
      _ => AuthStateChange.unknown,
    };
  }
}
