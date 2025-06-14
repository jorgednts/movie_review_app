import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';

class SearchRetryButton extends StatelessWidget {
  const SearchRetryButton({super.key, required this.onPressed});

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: Dimensions.spacingXs,
      children: [
        StyledText.t2(AppIntl.of(context).msg_load_error),
        FilledButton.icon(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              Theme.of(context).colorScheme.error,
            ),
          ),
          label: StyledText.b2(
            AppIntl.of(context).common_reload,
            fontColor: Theme.of(context).colorScheme.onError,
          ),
          icon: const Icon(Icons.refresh),
        ),
      ],
    );
  }
}
