
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';

import 'package:shopzy/example/domain/entities/example_user.dart';

final exampleUserFormMapperProvider = Provider<FormMapper<ExampleUser>>(
  (_) => ExampleUserForm.userFromJson,
);

abstract class ExampleUserForm {
  static const firstNameKey = 'firstName';
  static const lastNameKey = 'lastName';
  static const genderKey = 'gender';
  static const birthdayKey = 'birthday';

  static ExampleUser userFromJson(Map<String, dynamic> formMap) => ExampleUser(
    formMap[firstNameKey],
    formMap[lastNameKey],
    formMap[birthdayKey],
    formMap[genderKey],
  );

  static String? Function(T? value) minLengthName<T>() =>
      FormBuilderValidators.minLength(2, errorText: 'Nebu islo min');
  static String? Function(T? value) maxLengthName<T>() =>
      FormBuilderValidators.maxLength(6, errorText: 'Nebu islo max');
  static String? Function(T? value) isRequired<T>() =>
      FormBuilderValidators.required(errorText: 'Ovo polje je obavezno');
}
