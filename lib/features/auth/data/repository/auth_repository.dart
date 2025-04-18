import 'package:either_dart/either.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';
import 'package:shopzy/common/data/generic_error_resolver.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(),
  name: 'Authentication Repository Provider',
);

abstract interface class AuthRepository {
  EitherFailureOr<void> login({
    required String email,
    required String password,
  });

  EitherFailureOr<String?> getTokenIfAuthenticated();
  EitherFailureOr<void> socialLogin();
  EitherFailureOr<void> socialSignUp();
}

class AuthRepositoryImpl with ErrorToFailureMixin implements AuthRepository {
  @override
  EitherFailureOr<String?> getTokenIfAuthenticated() => execute(() async {
    await 1.seconds;
    return Right(null);
  }, errorResolver: GenericErrorResolver());

  @override
  EitherFailureOr<void> login({
    required String email,
    required String password,
  }) => execute(() async {
    await 1.seconds;
    return Right(null);
  }, errorResolver: GenericErrorResolver());

  @override
  EitherFailureOr<void> socialLogin() => execute(() async {
    final session = Supabase.instance.client.auth.currentSession;

    if (session == null) {
      throw AuthException('No active session found');
    }

    return Right(null);
  }, errorResolver: GenericErrorResolver());

  @override
  EitherFailureOr<void> socialSignUp() => execute(() async {
    final session = Supabase.instance.client.auth.currentSession;

    if (session == null) {
      throw AuthException('No active session found');
    }

    return Right(null);
  }, errorResolver: GenericErrorResolver());
}
