/// CustomTextField — Reusable, themed text field used across auth screens.
library;

import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.showObscureToggle = false,
    this.validator,
    this.onFieldSubmitted,
    this.focusNode,
    this.nextFocusNode,
    this.autofillHints,
  });

  final TextEditingController controller;
  final String label;
  final String? hint;
  final IconData? prefixIcon;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;

  /// Whether this field is a password field (starts hidden).
  final bool obscureText;

  /// Show the eye icon to toggle visibility (use with [obscureText] = true).
  final bool showObscureToggle;

  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;

  /// When set, pressing the keyboard "next" action moves focus here.
  final FocusNode? nextFocusNode;

  final Iterable<String>? autofillHints;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      obscureText: _obscure,
      autofillHints: widget.autofillHints,
      validator: widget.validator,
      onFieldSubmitted: (value) {
        if (widget.nextFocusNode != null) {
          FocusScope.of(context).requestFocus(widget.nextFocusNode);
        }
        widget.onFieldSubmitted?.call(value);
      },
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        prefixIcon:
            widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        // Show/hide password toggle
        suffixIcon: widget.showObscureToggle
            ? IconButton(
                icon: Icon(
                  _obscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                tooltip: _obscure
                    ? 'Afficher le mot de passe'
                    : 'Masquer le mot de passe',
                onPressed: () => setState(() => _obscure = !_obscure),
              )
            : null,
      ),
    );
  }
}
