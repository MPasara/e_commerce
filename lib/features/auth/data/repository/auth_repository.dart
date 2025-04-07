import 'package:either_dart/either.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';

import 'package:shopzy/common/data/generic_error_resolver.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(),
);

abstract interface class AuthRepository {
  EitherFailureOr<void> login({
    required String email,
    required String password,
  });

  EitherFailureOr<String?> getTokenIfAuthenticated();
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
}
