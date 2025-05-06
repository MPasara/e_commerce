import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final databaseServiceProvider = Provider<DatabaseService>(
  (ref) => DatabaseServiceImpl(Supabase.instance.client),
);

abstract interface class DatabaseService {
  Future<String?> getToken();

  Future<void> signInWithEmailPassword({
    required String email,
    required String password,
  });

  Future<void> signUpWithEmailPassword({
    required String email,
    required String password,
  });

  Future<void> signInWithSocialProvider(AuthProvider provider);
}

class DatabaseServiceImpl implements DatabaseService {
  final SupabaseClient _client;

  const DatabaseServiceImpl(this._client);

  @override
  Future<String?> getToken() async {
    final session = _client.auth.currentSession;
    return session?.accessToken;
  }

  @override
  Future<void> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.session == null) {
      throw AuthException('Login failed: No session created');
    }
  }

  @override
  Future<void> signUpWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
    );

    if (response.session == null) {
      throw AuthException('Sign up failed: No session created');
    }
  }

  @override
  Future<void> signInWithSocialProvider(AuthProvider provider) async {
    try {
      
      if (provider == AuthProvider.apple) {
       
        final appleProviderInfo = await _client.auth.getOAuthSignInUrl(
          provider: OAuthProvider.apple,
          redirectTo: kIsWeb ? null : 'io.supabase.flutter://login-callback/',
        );

        /* if (appleProviderInfo.isEmpty) {
          throw AuthException(
            'Apple login is not configured correctly in Supabase',
          );
        } */
      }

     
      await _client.auth.signInWithOAuth(
        provider.toSupabaseProvider(),
        redirectTo: kIsWeb ? null : 'io.supabase.flutter://login-callback/',
      );
    } catch (e) {
      throw AuthException('Social sign-in failed: $e');
    }
  }
}

enum AuthProvider { google, apple }

extension AuthProviderX on AuthProvider {
  OAuthProvider toSupabaseProvider() {
    switch (this) {
      case AuthProvider.google:
        return OAuthProvider.google;
      case AuthProvider.apple:
        return OAuthProvider.apple;
    }
  }
}
