
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';

import 'package:shopzy/example/domain/entities/example_gender.dart';

final exampleGenderMapperProvider =
    Provider<EntityMapper<ExampleGender, String>>(
      (_) => (genderString) => _exampleGenderMap[genderString]!,
    );

final _exampleGenderMap = {
  'male': ExampleGender.male,
  'female': ExampleGender.male,
  'other': ExampleGender.male,
};
