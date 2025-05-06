import 'package:either_dart/either.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';
import 'package:shopzy/common/data/generic_error_resolver.dart';
import 'package:shopzy/common/data/services/database_service.dart';

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
  EitherFailureOr<void> socialLogin({required AuthProvider provider});
  EitherFailureOr<void> socialSignUp({required AuthProvider provider});
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
  EitherFailureOr<void> socialLogin({required AuthProvider provider}) =>
      execute(() async {
        await _databaseService.signInWithSocialProvider(provider);
        return const Right(null);
      }, errorResolver: GenericErrorResolver());

  @override
  EitherFailureOr<void> socialSignUp({required AuthProvider provider}) =>
      execute(() async {
        await _databaseService.signInWithSocialProvider(provider);
        return const Right(null);
      }, errorResolver: GenericErrorResolver());
}
