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
    this.enabled = true,
    this.minLines,
    this.maxLines,
    this.constraints,
    this.keyboardType,
  });

  final TextEditingController? controller;
  final String label;
  final String? Function(String?)? validator;
  final InputDecoration? decoration;
  final bool obscureText;
  final bool expands;
  final bool autocorrect;
  final bool enabled;
  final BoxConstraints? constraints;
  final int? minLines;
  final int? maxLines;
  final TextInputType? keyboardType;

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
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      readOnly: !widget.enabled,
      keyboardType: widget.keyboardType,
      textAlignVertical: widget.expands ? TextAlignVertical.top : null,
      decoration:
          widget.decoration ??
          InputDecoration(
            constraints: widget.constraints,
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
