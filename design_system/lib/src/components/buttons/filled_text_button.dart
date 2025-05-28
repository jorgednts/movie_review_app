import 'package:flutter/material.dart';

class FilledTextButton extends StatelessWidget {
  final void Function() onPressed;
  final String label;
  final TextStyle? labelStyle;

  const FilledTextButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      child: Text(
        label,
        style:
            labelStyle ??
            Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
    );
  }
}
