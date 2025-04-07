
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/paginated_notifier.dart';

import 'package:shopzy/example/data/repositories/example_repository.dart';

final paginatedStreamNotifierProvider = NotifierProvider.autoDispose<
  ExamplePaginatedStreamNotifier,
  PaginatedState<String>
>(() => ExamplePaginatedStreamNotifier());

class ExamplePaginatedStreamNotifier
    extends AutoDisposePaginatedStreamNotifier<String, Object> {
  late ExampleRepository _repository;

  @override
  ({PaginatedState<String> initialState, bool useGlobalFailure})
  prepareForBuild() {
    _repository = ref.watch(exampleRepositoryProvider);
    getInitialList();
    return (initialState: PaginatedState.loading(), useGlobalFailure: true);
  }

  @override
  PaginatedStreamFailureOr<String> getListStreamOrFailure(
    int page, [
    Object? parameter,
  ]) => _repository.getPaginatedStreamResult(page);
}
