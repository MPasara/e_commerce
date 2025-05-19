import 'package:either_dart/either.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';
import 'package:shopzy/common/data/generic_error_resolver.dart';
import 'package:shopzy/common/data/services/database_service.dart';
import 'package:shopzy/features/auth/domain/enums/auth_state_change.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(ref.read(databaseServiceProvider)),
  name: 'Authentication Repository Provider',
);

abstract interface class AuthRepository {
  EitherFailureOr<void> login({
    required String email,
    required String password,
  });

  EitherFailureOr<void> signUp({
    required String email,
    required String password,
  });

  EitherFailureOr<String?> getTokenIfAuthenticated();
  EitherFailureOr<void> appleLogin();
  EitherFailureOr<void> googleLogin();
  Stream<AuthStateChange> onAuthStateChange();
  EitherFailureOr<void> logout();
}

class AuthRepositoryImpl with ErrorToFailureMixin implements AuthRepository {
  final DatabaseService _databaseService;

  AuthRepositoryImpl(this._databaseService);

  @override
  EitherFailureOr<String?> getTokenIfAuthenticated() => execute(() async {
    return Right(await _databaseService.getToken());
  }, errorResolver: GenericErrorResolver());

  @override
  EitherFailureOr<void> login({
    required String email,
    required String password,
  }) => execute(() async {
    await _databaseService.signInWithEmailPassword(
      email: email,
      password: password,
    );
    return const Right(null);
  }, errorResolver: GenericErrorResolver());

  @override
  EitherFailureOr<void> signUp({
    required String email,
    required String password,
  }) => execute(() async {
    await _databaseService.signUpWithEmailPassword(
      email: email,
      password: password,
    );
    return const Right(null);
  }, errorResolver: GenericErrorResolver());

  @override
  EitherFailureOr<void> appleLogin() => execute(() async {
    await _databaseService.signInWithApple();
    return const Right(null);
  }, errorResolver: GenericErrorResolver());

  @override
  EitherFailureOr<void> googleLogin() => execute(() async {
    await _databaseService.signInWithGoogle();
    return const Right(null);
  }, errorResolver: GenericErrorResolver());

  @override
  Stream<AuthStateChange> onAuthStateChange() {
    return _databaseService.onAuthStateChange();
  }

  @override
  EitherFailureOr<void> logout() => execute(() async {
    await _databaseService.logout();
    return const Right(null);
  }, errorResolver: GenericErrorResolver());
}
