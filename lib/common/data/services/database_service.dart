import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopzy/common/constants/supabase_constants.dart';
import 'package:shopzy/features/auth/domain/enums/auth_state_change.dart';
import 'package:shopzy/features/product/data/models/product_response.dart';
import 'package:shopzy/generated/l10n.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final databaseServiceProvider = Provider<DatabaseService>(
  (ref) => DatabaseServiceImpl(Supabase.instance.client),
  name: 'Database Service Provider',
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
  Future<void> signInWithGoogle();
  Future<void> signInWithApple();
  Stream<AuthStateChange> onAuthStateChange();
  Future<void> logout();

  Future<({List<ProductResponse> items, int totalCount})> fetchProducts({
    int offset = 0,
    int limit = 10,
  });
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
    final user = response.user;

    if (user == null) {
      throw AuthException(S.current.signUpFailed);
    }
  }

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
      throw AuthException(S.current.appleIdTokenNotFound);
    }
    await _client.auth.signInWithIdToken(
      provider: OAuthProvider.apple,
      idToken: idToken,
      nonce: rawNonce,
    );
  }

  @override
  Future<void> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn(
      clientId: SupabaseConstants.googleIosClientId,
      serverClientId: SupabaseConstants.googleWebClientId,
    );
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      throw AuthException(S.current.googleSignInCancelled);
    }
    final googleAuth = await googleUser.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;
    if (accessToken == null) {
      throw AuthException(S.current.googleAccessTokenNotFound);
    }
    if (idToken == null) {
      throw AuthException(S.current.googleIdTokenNotFound);
    }
    await _client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  @override
  Stream<AuthStateChange> onAuthStateChange() {
    return _client.auth.onAuthStateChange.map((event) {
      return AuthStateChange.fromSupabaseEvent(event.event);
    });
  }

  @override
  Future<void> logout() async {
    try {
      await _client.auth.signOut();
    } catch (e) {
      throw AuthException(S.current.signOutFailed(e.toString()));
    }
  }

  @override
  Future<({List<ProductResponse> items, int totalCount})> fetchProducts({
    int offset = 0,
    int limit = 10,
  }) async {
    // Get total count
    final countResponse =
        await _client.from(SupabaseConstants.productTable).count();
    final totalCount = countResponse;

    // Get items
    final to = offset + limit - 1;
    final response = await _client
        .from(SupabaseConstants.productTable)
        .select()
        .range(offset, to);

    final List<ProductResponse> products =
        response.map((product) => ProductResponse.fromJson(product)).toList();

    return (items: products, totalCount: totalCount);
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
