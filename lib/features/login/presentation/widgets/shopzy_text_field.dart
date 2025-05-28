import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:shopzy/common/presentation/build_context_extensions.dart';
import 'package:shopzy/common/presentation/form_builder_keys.dart';
import 'package:shopzy/generated/l10n.dart';

class ShopzyTextField extends StatefulWidget {
  const ShopzyTextField._({
    required this.textFieldName,
    required this.hintText,
    this.fieldValidator,
    this.obscureText = false,
    this.keyboardType,
    this.showPasswordToggle = false,
    this.formState,
    this.onChanged,
    this.suffixIcon,
  });

  final String textFieldName;
  final String hintText;
  final String? Function(String?)? fieldValidator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final bool showPasswordToggle;
  final FormBuilderState? formState;
  final void Function(String?)? onChanged;
  final Widget? suffixIcon;

  factory ShopzyTextField.search() {
    return ShopzyTextField._(
      textFieldName: FormBuilderKeys.search,
      hintText: S.current.searchHint,
      keyboardType: TextInputType.text,
      onChanged: (value) {},
    );
  }

  factory ShopzyTextField.email() {
    return ShopzyTextField._(
      textFieldName: FormBuilderKeys.email,
      hintText: S.current.emailHint,
      keyboardType: TextInputType.emailAddress,
      fieldValidator: FormBuilderValidators.compose(
        FormValidators.emailValidators,
      ),
    );
  }

  factory ShopzyTextField.password() {
    return ShopzyTextField._(
      textFieldName: FormBuilderKeys.password,
      hintText: S.current.passwordHint,
      obscureText: true,
      showPasswordToggle: true,
      fieldValidator: FormBuilderValidators.compose(
        FormValidators.passwordValidators,
      ),
    );
  }

  factory ShopzyTextField.confirmPassword([
    String? Function(String?)? validator,
  ]) {
    return ShopzyTextField._(
      textFieldName: FormBuilderKeys.confirmPassword,
      hintText: S.current.confirmPasswordHint,
      obscureText: true,
      showPasswordToggle: true,
      fieldValidator: FormBuilderValidators.compose([
        ...FormValidators.passwordValidators,
        if (validator != null) validator,
      ]),
    );
  }

  @override
  State<ShopzyTextField> createState() => _ShopzyTextFieldState();
}

class _ShopzyTextFieldState extends State<ShopzyTextField> {
  late bool _obscureText;
  final TextEditingController _controller = TextEditingController();
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final showClearButton = _controller.text.isNotEmpty;
    if (showClearButton != _showClearButton) {
      setState(() {
        _showClearButton = showClearButton;
      });
    }
  }

  void _clearText() {
    _controller.clear();
    if (widget.formState != null) {
      widget.formState!.fields[widget.textFieldName]?.didChange(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: widget.textFieldName,
      controller: _controller,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.fieldValidator,
      onChanged: widget.onChanged,
      style: context.appTextStyles.regular?.copyWith(
        color: context.appColors.secondary,
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: context.appTextStyles.regular?.copyWith(
          color: context.appColors.greyText,
        ),
        filled: true,
        fillColor: context.appColors.appTextFieldFill,
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
                    color: context.appColors.greyText,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
                : IconButton(
                  icon: Icon(
                    _showClearButton ? Icons.close : Icons.search,
                    color: context.appColors.greyText,
                  ),
                  onPressed: _showClearButton ? _clearText : null,
                ),
      ),
    );
  }
}
