
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';

import 'package:shopzy/example/data/repositories/example_repository.dart';
import 'package:shopzy/example/domain/notifiers/example_simple_notifier/example_simple_state.dart';

final exampleSimpleNotifierProvider =
    NotifierProvider.autoDispose<ExampleSimpleNotifier, ExampleSimpleState>(
      () => ExampleSimpleNotifier(),
    );

class ExampleSimpleNotifier
    extends AutoDisposeSimpleNotifier<ExampleSimpleState> {
  late ExampleRepository _exampleRepository;

  @override
  ExampleSimpleState prepareForBuild() {
    _exampleRepository = ref.watch(exampleRepositoryProvider);
    return ExampleSimpleState.initial();
  }

  /// Example method when you want to get state updates when calling some repository method
  Future<void> getSomeStringSimpleExample() async {
    await debounce();
    state = ExampleSimpleState.fetching();
    final result = await _exampleRepository.getSomeOtherString();
    result.fold(
      (failure) {
        state = ExampleSimpleState.error(failure);
      },
      (data) {
        if (data.isEmpty) {
          state = ExampleSimpleState.empty();
        } else {
          state = ExampleSimpleState.success(data);
        }
      },
    );
  }

  /// Example method when you want to use global loading and global failure methods
  /// when calling some repository method
  Future<void> getSomeStringSimpleExampleGlobalLoading() async {
    showGlobalLoading();
    final result = await _exampleRepository.getSomeOtherString();
    result.fold(
      (failure) {
        setGlobalFailure(failure);
      },
      (data) {
        clearGlobalLoading();
        if (data.isEmpty) {
          state = ExampleSimpleState.empty();
        } else {
          state = ExampleSimpleState.success(data);
        }
      },
    );
  }
}
