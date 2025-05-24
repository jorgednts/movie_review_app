import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class DefaultNavigationBar extends StatelessWidget {
  const DefaultNavigationBar({
    super.key,
    required this.navigationMenu,
    this.leading,
    this.trailing,
    this.padding = const EdgeInsets.only(left: Dimensions.spacingMd),
    this.navigationMenuPadding = const EdgeInsets.symmetric(
      horizontal: Dimensions.spacingMd,
      vertical: Dimensions.spacingMd,
    ),
    this.trailingPadding = const EdgeInsets.symmetric(
      horizontal: Dimensions.spacingLg,
    ),
  });

  final Widget navigationMenu;
  final EdgeInsets navigationMenuPadding;
  final Widget? leading;
  final EdgeInsets padding;
  final Widget? trailing;
  final EdgeInsets trailingPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: Dimensions.spacingMd,
        children: [
          if (leading != null) leading!,
          Flexible(
            child: Padding(
              padding: navigationMenuPadding,
              child: navigationMenu,
            ),
          ),
          if (trailing != null)
            Padding(padding: trailingPadding, child: trailing!),
        ],
      ),
    );
  }
}
