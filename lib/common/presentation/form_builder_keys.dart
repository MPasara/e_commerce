import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:shopzy/generated/l10n.dart';

/// Constants for form field names used across the application
class FormBuilderKeys {
  // Authentication form fields
  static const email = 'email';
  static const password = 'password';
  static const confirmPassword = 'confirm_password';

  // Private constructor to prevent instantiation
  const FormBuilderKeys._();
}

/// Common form validators used across the application
class FormValidators {
  /// Email field validators
  static List<FormFieldValidator<String>> get emailValidators => [
    FormBuilderValidators.required(),
    FormBuilderValidators.email(),
  ];

  /// Password field validators
  static List<FormFieldValidator<String>> get passwordValidators => [
    FormBuilderValidators.required(),
    FormBuilderValidators.minLength(
      6,
      errorText: S.current.passwordValidationError,
    ),
  ];
}
