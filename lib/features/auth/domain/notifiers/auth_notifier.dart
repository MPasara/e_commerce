import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';
import 'package:shopzy/common/data/services/database_service.dart';
import 'package:shopzy/common/domain/providers/base_router_provider.dart';
import 'package:shopzy/features/auth/data/repository/auth_repository.dart';
import 'package:shopzy/features/auth/domain/notifiers/auth_state.dart';
import 'package:shopzy/features/home/presentation/home_page.dart';
import 'package:shopzy/features/login/presentation/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(
  () => AuthNotifier(),
  name: 'Authentication Notifier Provider',
);

class AuthNotifier extends SimpleNotifier<AuthState> implements Listenable {
  late AuthRepository _authRepository;
  VoidCallback? _routerListener;
  String? _deepLink;

  @override
  AuthState prepareForBuild() {
    _authRepository = ref.watch(authRepositoryProvider);

    supabase.Supabase.instance.client.auth.onAuthStateChange.listen((event) {
      if (event.event == supabase.AuthChangeEvent.signedIn) {
        state = AuthState.authenticated();
        clearGlobalLoading();
        _routerListener?.call();
      } else if (event.event == supabase.AuthChangeEvent.signedOut) {
        state = AuthState.unauthenticated();
        clearGlobalLoading();
        _routerListener?.call();
      }
    });

    checkIfAuthenticated();
    return AuthState.initial();
  }

  Future<void> checkIfAuthenticated() async {
    showGlobalLoading();
    final result = await _authRepository.getTokenIfAuthenticated();
    result.fold(
      (failure) {
        setGlobalFailure(failure);
        state = AuthState.unauthenticated();
      },
      (token) {
        state =
            token != null
                ? AuthState.authenticated()
                : AuthState.unauthenticated();
      },
    );
    clearGlobalLoading();
    _routerListener?.call();
  }

  Future<void> login({required String email, required String password}) async {
    showGlobalLoading();
    state = AuthState.authenticating();
    final result = await _authRepository.login(
      email: email,
      password: password,
    );

    result.fold(
      (failure) {
        setGlobalFailure(failure);
        state = AuthState.unauthenticated();
        clearGlobalLoading();
      },
      (response) {
        state = AuthState.authenticated();
        clearGlobalLoading();
      },
    );
    _routerListener?.call();
  }

  Future<void> socialLogin({required AuthProvider provider}) async {
    state = AuthState.authenticating();

    try {
      final result = await _authRepository.socialLogin(provider: provider);

      result.fold(
        (failure) {
          setGlobalFailure(failure);
          state = AuthState.unauthenticated();
          clearGlobalLoading();
          _routerListener?.call();
        },
        (_) {
          Future.delayed(const Duration(seconds: 30), () {
            clearGlobalLoading();
          });
        },
      );
    } catch (e) {
      debugPrint('Social login error: $e');
      setGlobalFailure(Failure.generic(title: 'Social login failed: $e'));
      state = AuthState.unauthenticated();
      clearGlobalLoading();
      _routerListener?.call();
    }
  }

  Future<void> socialSignUp({required AuthProvider provider}) async {
    showGlobalLoading();
    state = AuthState.authenticating();

    try {
      final result = await _authRepository.socialSignUp(provider: provider);

      result.fold(
        (failure) {
          setGlobalFailure(failure);
          state = AuthState.unauthenticated();
          clearGlobalLoading();
          _routerListener?.call();
        },
        (_) {
          Future.delayed(const Duration(seconds: 30), () {
            clearGlobalLoading();
          });
        },
      );
    } catch (e) {
      debugPrint('Social signup error: $e');
      setGlobalFailure(Failure.generic(title: 'Social signup failed: $e'));
      state = AuthState.unauthenticated();
      clearGlobalLoading();
      _routerListener?.call();
    }
  }

  Future<void> signUp({required String email, required String password}) async {
    showGlobalLoading();
    state = AuthState.authenticating();
    final result = await _authRepository.signUp(
      email: email,
      password: password,
    );

    result.fold(
      (failure) {
        setGlobalFailure(failure);
        state = AuthState.unauthenticated();
        clearGlobalLoading();
      },
      (response) {
        state = AuthState.authenticated();
        clearGlobalLoading();
      },
    );
    _routerListener?.call();
  }

  Future<void> logout() async {
    showGlobalLoading();
    try {
      await supabase.Supabase.instance.client.auth.signOut();
    } catch (e) {
      debugPrint('Logout failed: $e');
      clearGlobalLoading();
    }
  }

  String? redirect({
    required GoRouterState goRouterState,
    required bool showErrorIfNonExistentRoute,
  }) {
    final isAuthenticating = switch (state) {
      AuthStateInitial() || AuthStateAuthenticating() => true,
      _ => false,
    };
    if (isAuthenticating) return null;

    final isLoggedIn = switch (state) {
      AuthStateAuthenticated() => true,
      _ => false,
    };

    final isAuthRoute =
        goRouterState.matchedLocation == LoginPage.routeName ||
        goRouterState.matchedLocation.startsWith(LoginPage.routeName);

    if (isAuthRoute) {
      if (isLoggedIn) {
        if (_deepLink != null) {
          final tmpDeepLink = _deepLink;
          _deepLink = null;
          return tmpDeepLink;
        }
        return HomePage.routeName;
      }
      return null;
    }

    final routeExists = ref
        .read(baseRouterProvider)
        .doesRouteExists(goRouterState.matchedLocation);

    final authRoutes = goRouterState.matchedLocation.startsWith(
      LoginPage.routeName,
    );

    if (isLoggedIn && routeExists) {
      return authRoutes ? HomePage.routeName : null;
    }

    _deepLink =
        !authRoutes && routeExists ? goRouterState.uri.toString() : null;

    return authRoutes || (showErrorIfNonExistentRoute && !routeExists)
        ? null
        : LoginPage.routeName;
  }

  @override
  void addListener(VoidCallback listener) => _routerListener = listener;

  @override
  void removeListener(VoidCallback listener) => _routerListener = null;
}
