import 'package:q_architecture/q_architecture.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

final class GenericErrorResolver implements ErrorResolver {
  final String? failureTitle;

  const GenericErrorResolver({this.failureTitle});

  @override
  Failure resolve<T>(Object err, [StackTrace? stackTrace]) {
    final message = err is String ? err : err.toString();
    if (err is! String) Sentry.captureException(err, stackTrace: stackTrace);
    return Failure.generic(
      title: failureTitle ?? message,
      error: err,
      stackTrace: stackTrace,
    );
  }
}
