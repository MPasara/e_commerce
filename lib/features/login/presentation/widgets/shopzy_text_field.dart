import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:shopzy/generated/l10n.dart';

class ShopzyTextField extends StatefulWidget {
  const ShopzyTextField._({
    required this.textFieldName,
    required this.hintText,
    this.fieldValidator,
    this.obscureText = false,
    this.keyboardType,
    this.showPasswordToggle = false,
  });

  final String textFieldName;
  final String hintText;
  final String? Function(String?)? fieldValidator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final bool showPasswordToggle;

  factory ShopzyTextField.email() {
    return ShopzyTextField._(
      textFieldName: 'email',
      hintText: S.current.emailHint,
      keyboardType: TextInputType.emailAddress,
      fieldValidator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.email(),
      ]),
    );
  }

  factory ShopzyTextField.password() {
    return ShopzyTextField._(
      textFieldName: 'password',
      hintText: S.current.passwordHint,
      obscureText: true,
      showPasswordToggle: true,
      fieldValidator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.minLength(
          6,
          errorText: S.current.passwordValidationError,
        ),
      ]),
    );
  }

  factory ShopzyTextField.confirmPassword() {
    return ShopzyTextField._(
      textFieldName: 'confirm_password',
      hintText: S.current.confirmPasswordHint,
      obscureText: true,
      showPasswordToggle: true,
      fieldValidator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.minLength(
          6,
          errorText: S.current.passwordValidationError,
        ),
      ]),
    );
  }

  @override
  State<ShopzyTextField> createState() => _ShopzyTextFieldState();
}

class _ShopzyTextFieldState extends State<ShopzyTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: widget.textFieldName,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.fieldValidator,
      decoration: InputDecoration(
        hintText: widget.hintText,
        filled: true,
        fillColor: const Color(0xffFAFAFA),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide.none,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide.none,
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide.none,
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.red, width: 1.5),
        ),
        suffixIcon:
            widget.showPasswordToggle
                ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
                : null,
      ),
    );
  }
}
