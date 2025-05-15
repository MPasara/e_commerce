import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopzy/generated/l10n.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
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

  //Future<void> signInWithSocialProvider(AuthProvider provider);
  Future<void> signInWithGoogle();
  Future<void> signInWithApple();
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
      throw AuthException(S.current.loginFailed);
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
      throw AuthException(S.current.signUpFailed);
    }
  }

  /* @override
  Future<void> signInWithSocialProvider(AuthProvider provider) async {
    if (provider == AuthProvider.apple) {
      final rawNonce = _client.auth.generateRawNonce();
      final hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();
      final appleCredentials = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: hashedNonce,
      );

      final idToken = appleCredentials.identityToken;
      if (idToken == null) {
        throw const AuthException(
          'Could not find ID Token from generated credential.',
        );
      }
      _client.auth.signInWithIdToken(
        provider: OAuthProvider.apple,
        idToken: idToken,
        nonce: rawNonce,
      );
    } /* else {
      await _client.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo:
            kIsWeb
                ? null
                : 'my.scheme://my-host', // Optionally set the redirect link to bring back the user via deeplink.
        authScreenLaunchMode:
            kIsWeb
                ? LaunchMode.platformDefault
                : LaunchMode
                    .externalApplication, // Launch the auth screen in a new webview on mobile.
      );
    } */ else {
      const webClientId =
          '104131253486-d3hk2b26ij52q5fu310q73suuvhu23n3.apps.googleusercontent.com';

      const iosClientId =
          '104131253486-qel5fit1986bnlbqj22nfab0rcu32tum.apps.googleusercontent.com';
      await _client.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo:
            kIsWeb
                ? null
                : 'my.scheme://my-host', // Optionally set the redirect link to bring back the user via deeplink.
        authScreenLaunchMode:
            kIsWeb
                ? LaunchMode.platformDefault
                : LaunchMode
                    .externalApplication, // Launch the auth screen in a new webview on mobile.
      );
      /* final  googleSignIn = GoogleSignIn(
        clientId: iosClientId,
        serverClientId: webClientId,
      );
      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;
      if (accessToken == null) {
        throw 'No Access Token found.';
      }
      if (idToken == null) {
        throw 'No ID Token found.';
      }
      await _client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      ); */
    }
  }
 */
  @override
  Future<void> signInWithApple() async {
    final rawNonce = _client.auth.generateRawNonce();
    final hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();
    final appleCredentials = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: hashedNonce,
    );

    final idToken = appleCredentials.identityToken;
    if (idToken == null) {
      throw const AuthException(
        'Could not find ID Token from generated credential.',
      );
    }
    _client.auth.signInWithIdToken(
      provider: OAuthProvider.apple,
      idToken: idToken,
      nonce: rawNonce,
    );
  }

  @override
  Future<void> signInWithGoogle() async {
    /* const webClientId =
        '104131253486-d3hk2b26ij52q5fu310q73suuvhu23n3.apps.googleusercontent.com';

    const iosClientId =
        '104131253486-qel5fit1986bnlbqj22nfab0rcu32tum.apps.googleusercontent.com';
    await _client.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo:
          kIsWeb
              ? null
              : 'my.scheme://my-host', // Optionally set the redirect link to bring back the user via deeplink.
      authScreenLaunchMode:
          kIsWeb
              ? LaunchMode.platformDefault
              : LaunchMode
                  .externalApplication, // Launch the auth screen in a new webview on mobile.
    ); */
    const webClientId =
        '104131253486-d3hk2b26ij52q5fu310q73suuvhu23n3.apps.googleusercontent.com';

    const iosClientId =
        '104131253486-qel5fit1986bnlbqj22nfab0rcu32tum.apps.googleusercontent.com';
    final googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;
    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }
    await _client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
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
