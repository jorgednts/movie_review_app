import 'package:flutter/material.dart';

import '../../tokens/dimensions/dimensions.dart';

class ConstrainedDialog extends StatelessWidget {
  const ConstrainedDialog({
    super.key,
    required this.boxConstraints,
    required this.content,
    required this.onPop,
    this.dialogPadding = const EdgeInsets.all(Dimensions.spacingMd),
    this.contentSpacing = Dimensions.spacingMd,
    this.title = const Spacer(),
  });

  final Widget title;
  final BoxConstraints boxConstraints;
  final EdgeInsets dialogPadding;
  final double contentSpacing;
  final Widget content;
  final void Function() onPop;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: boxConstraints,
        child: Padding(
          padding: dialogPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: contentSpacing,
            children: [
              Stack(
                children: [
                  title,
                  Align(
                    alignment: Alignment.topRight,
                    child: CloseButton(onPressed: onPop),
                  ),
                ],
              ),
              Flexible(child: content),
            ],
          ),
        ),
      ),
    );
  }
}
