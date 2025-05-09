
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';

import 'package:shopzy/example/forms/example_user_form.dart';
import 'package:shopzy/example/domain/entities/example_user.dart';

final formExampleNotifierProvider = NotifierProvider<FormExampleNotifier, void>(
  () => FormExampleNotifier(),
);

class FormExampleNotifier extends SimpleNotifier<void> {
  late FormMapper<ExampleUser> _userFormMapper;

  @override
  void prepareForBuild() {
    _userFormMapper = ref.watch(exampleUserFormMapperProvider);
  }

  void submitForm(Map<String, dynamic> formMap) {
    final user = _userFormMapper(formMap);
    // ignore: avoid_print
    print('Sending user to API: $user');
  }
}
