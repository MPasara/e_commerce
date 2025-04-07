import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';

import 'package:shopzy/common/domain/providers/base_router_provider.dart';
import 'package:shopzy/features/home/presentation/home_page.dart';
import 'package:shopzy/features/login/presentation/login_page.dart';
import 'package:shopzy/features/auth/data/repository/auth_repository.dart';
import 'package:shopzy/features/auth/domain/notifiers/auth_state.dart';

final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(
  () => AuthNotifier(),
);

class AuthNotifier extends SimpleNotifier<AuthState> implements Listenable {
  late AuthRepository _authRepository;
  VoidCallback? _routerListener;
  String? _deepLink;

  @override
  AuthState prepareForBuild() {
    _authRepository = ref.watch(authRepositoryProvider);
    checkIfAuthenticated();
    return AuthState.initial();
  }

  Future<void> checkIfAuthenticated() async {
    await 100.milliseconds;
    showGlobalLoading();
    final result = await _authRepository.getTokenIfAuthenticated();
    result.fold(
      (failure) {
        setGlobalFailure(failure);
        state = AuthState.unauthenticated();
        _routerListener?.call();
      },
      (token) {
        clearGlobalLoading();
        state =
            token != null
                ? AuthState.authenticated()
                : AuthState.unauthenticated();
        _routerListener?.call();
      },
    );
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
        _routerListener?.call();
      },
      (response) {
        clearGlobalLoading();
        state = AuthState.authenticated();
        _routerListener?.call();
      },
    );
  }

  Future<void> logout() async {
    await 500.milliseconds;
    state = AuthState.unauthenticated();
    _routerListener?.call();
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
    final loggingIn = goRouterState.matchedLocation == LoginPage.routeName;
    if (loggingIn) {
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
    final loginRoutes = goRouterState.matchedLocation.startsWith(
      LoginPage.routeName,
    );
    if (isLoggedIn && routeExists) {
      return loginRoutes ? HomePage.routeName : null;
    }
    _deepLink =
        !loginRoutes && routeExists ? goRouterState.uri.toString() : null;
    return loginRoutes || (showErrorIfNonExistentRoute && !routeExists)
        ? null
        : LoginPage.routeName;
  }

  @override
  void addListener(VoidCallback listener) => _routerListener = listener;

  @override
  void removeListener(VoidCallback listener) => _routerListener = null;
}
