import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';
import 'package:shopzy/common/domain/providers/base_router_provider.dart';
import 'package:shopzy/features/auth/data/repository/auth_repository.dart';
import 'package:shopzy/features/auth/domain/enums/auth_state_change.dart';
import 'package:shopzy/features/auth/domain/notifiers/auth_state.dart';
import 'package:shopzy/features/home/presentation/home_page.dart';
import 'package:shopzy/features/login/presentation/login_page.dart';
import 'package:shopzy/generated/l10n.dart';

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

    _authRepository.onAuthStateChange().listen((event) {
      switch (event) {
        case AuthStateChange.signedIn:
          state = AuthState.authenticated();
          clearGlobalLoading();
          _routerListener?.call();
        case AuthStateChange.signedOut:
          state = AuthState.unauthenticated();
          clearGlobalLoading();
          _routerListener?.call();
        default:
          break;
      }
    });

    Future.microtask(() => checkIfAuthenticated());

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
        setGlobalInfo(
          GlobalInfo(
            globalInfoStatus: GlobalInfoStatus.success,
            message: S.current.authSuccess,
          ),
        );
        clearGlobalLoading();
      },
    );
    _routerListener?.call();
  }

  Future<void> socialLogin({required bool isApple}) async {
    state = AuthState.authenticating();
    final result = await _authRepository.socialLogin(isApple);

    result.fold(
      (failure) {
        setGlobalFailure(failure);
        state = AuthState.unauthenticated();

        clearGlobalLoading();
        _routerListener?.call();
      },
      (response) {
        state = AuthState.authenticated();
        clearGlobalLoading();
        _routerListener?.call();
        setGlobalInfo(
          GlobalInfo(
            globalInfoStatus: GlobalInfoStatus.success,
            message: S.current.authSuccess,
          ),
        );
      },
    );
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

        setGlobalInfo(
          GlobalInfo(
            globalInfoStatus: GlobalInfoStatus.success,
            message: S.current.sign_up_success,
          ),
        );
        clearGlobalLoading();
      },
    );
    _routerListener?.call();
  }

  Future<void> logout() async {
    showGlobalLoading();
    final result = await _authRepository.logout();
    result.fold(
      (failure) {
        setGlobalFailure(failure);

        clearGlobalLoading();
      },
      (_) {
        state = AuthState.unauthenticated();

        setGlobalInfo(
          GlobalInfo(
            globalInfoStatus: GlobalInfoStatus.success,
            message: S.current.logoutSuccess,
          ),
        );
        clearGlobalLoading();
        _routerListener?.call();
      },
    );
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
