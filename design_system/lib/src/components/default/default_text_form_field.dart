import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class DefaultTextFormField extends StatefulWidget {
  const DefaultTextFormField({
    super.key,
    required this.label,
    this.validator,
    this.controller,
    this.decoration,
    this.obscureText = false,
    this.expands = false,
    this.autocorrect = false,
  });

  final TextEditingController? controller;
  final String label;
  final String? Function(String?)? validator;
  final InputDecoration? decoration;
  final bool obscureText;
  final bool expands;
  final bool autocorrect;

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  bool obscureText = false;

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
  }

  void toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      expands: widget.expands,
      autocorrect: widget.autocorrect,
      maxLines: widget.expands ? null : 1,
      minLines: widget.expands ? null : 1,
      textAlignVertical: widget.expands ? TextAlignVertical.top : null,
      decoration:
          widget.decoration ??
          InputDecoration(
            labelText: widget.label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radiusLg),
            ),
            suffixIcon:
                widget.obscureText
                    ? InkWell(
                      onTap: toggleObscureText,
                      overlayColor: WidgetStateColor.transparent,
                      child: Icon(
                        obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                    )
                    : null,
          ),
      validator: widget.validator,
      obscureText: obscureText,
    );
  }
}
