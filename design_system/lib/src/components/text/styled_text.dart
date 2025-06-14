import 'package:flutter/material.dart';

enum TextTypeScale { label, body, title, headline, display }

enum TextSize { small, medium, large }

class StyledText extends StatelessWidget {
  const StyledText.l1(
    this.data, {
    super.key,
    this.isBold = false,
    this.isItalic = false,
    this.fontColor,
    this.overflow,
    this.maxLines,
    this.textAlign,
    this.softWrap,
  }) : _typeScale = TextTypeScale.label,
       _textSize = TextSize.small;

  const StyledText.l2(
    this.data, {
    super.key,
    this.isBold = false,
    this.isItalic = false,
    this.fontColor,
    this.overflow,
    this.maxLines,
    this.textAlign,
    this.softWrap,
  }) : _typeScale = TextTypeScale.label,
       _textSize = TextSize.medium;

  const StyledText.l3(
    this.data, {
    super.key,
    this.isBold = false,
    this.isItalic = false,
    this.fontColor,
    this.overflow,
    this.maxLines,
    this.textAlign,
    this.softWrap,
  }) : _typeScale = TextTypeScale.label,
       _textSize = TextSize.large;

  const StyledText.b1(
    this.data, {
    super.key,
    this.isBold = false,
    this.isItalic = false,
    this.fontColor,
    this.overflow,
    this.maxLines,
    this.textAlign,
    this.softWrap,
  }) : _typeScale = TextTypeScale.body,
       _textSize = TextSize.small;

  const StyledText.b2(
    this.data, {
    super.key,
    this.isBold = false,
    this.isItalic = false,
    this.fontColor,
    this.overflow,
    this.maxLines,
    this.textAlign,
    this.softWrap,
  }) : _typeScale = TextTypeScale.body,
       _textSize = TextSize.medium;

  const StyledText.b3(
    this.data, {
    super.key,
    this.isBold = false,
    this.isItalic = false,
    this.fontColor,
    this.overflow,
    this.maxLines,
    this.textAlign,
    this.softWrap,
  }) : _typeScale = TextTypeScale.body,
       _textSize = TextSize.large;

  const StyledText.t1(
    this.data, {
    super.key,
    this.isBold = false,
    this.isItalic = false,
    this.fontColor,
    this.overflow,
    this.maxLines,
    this.textAlign,
    this.softWrap,
  }) : _typeScale = TextTypeScale.title,
       _textSize = TextSize.small;

  const StyledText.t2(
    this.data, {
    super.key,
    this.isBold = false,
    this.isItalic = false,
    this.fontColor,
    this.overflow,
    this.maxLines,
    this.textAlign,
    this.softWrap,
  }) : _typeScale = TextTypeScale.title,
       _textSize = TextSize.medium;

  const StyledText.t3(
    this.data, {
    super.key,
    this.isBold = false,
    this.isItalic = false,
    this.fontColor,
    this.overflow,
    this.maxLines,
    this.textAlign,
    this.softWrap,
  }) : _typeScale = TextTypeScale.title,
       _textSize = TextSize.large;

  const StyledText.h1(
    this.data, {
    super.key,
    this.isBold = false,
    this.isItalic = false,
    this.fontColor,
    this.overflow,
    this.maxLines,
    this.textAlign,
    this.softWrap,
  }) : _typeScale = TextTypeScale.headline,
       _textSize = TextSize.small;

  const StyledText.h2(
    this.data, {
    super.key,
    this.isBold = false,
    this.isItalic = false,
    this.fontColor,
    this.overflow,
    this.maxLines,
    this.textAlign,
    this.softWrap,
  }) : _typeScale = TextTypeScale.headline,
       _textSize = TextSize.medium;

  const StyledText.h3(
    this.data, {
    super.key,
    this.isBold = false,
    this.isItalic = false,
    this.fontColor,
    this.overflow,
    this.maxLines,
    this.textAlign,
    this.softWrap,
  }) : _typeScale = TextTypeScale.headline,
       _textSize = TextSize.large;

  const StyledText.d1(
    this.data, {
    super.key,
    this.isBold = false,
    this.isItalic = false,
    this.fontColor,
    this.overflow,
    this.maxLines,
    this.textAlign,
    this.softWrap,
  }) : _typeScale = TextTypeScale.display,
       _textSize = TextSize.small;

  const StyledText.d2(
    this.data, {
    super.key,
    this.isBold = false,
    this.isItalic = false,
    this.fontColor,
    this.overflow,
    this.maxLines,
    this.textAlign,
    this.softWrap,
  }) : _typeScale = TextTypeScale.display,
       _textSize = TextSize.medium;

  const StyledText.d3(
    this.data, {
    super.key,
    this.isBold = false,
    this.isItalic = false,
    this.fontColor,
    this.overflow,
    this.maxLines,
    this.textAlign,
    this.softWrap,
  }) : _typeScale = TextTypeScale.display,
       _textSize = TextSize.large;

  final String data;
  final TextTypeScale _typeScale;
  final TextSize _textSize;
  final bool isBold;
  final bool isItalic;
  final Color? fontColor;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextAlign? textAlign;
  final bool? softWrap;

  TextStyle? getStyle(ThemeData theme) {
    return switch (_typeScale) {
      TextTypeScale.label => switch (_textSize) {
        TextSize.small => theme.textTheme.labelSmall,
        TextSize.medium => theme.textTheme.labelMedium,
        TextSize.large => theme.textTheme.labelLarge,
      },
      TextTypeScale.body => switch (_textSize) {
        TextSize.small => theme.textTheme.bodySmall,
        TextSize.medium => theme.textTheme.bodyMedium,
        TextSize.large => theme.textTheme.bodyLarge,
      },
      TextTypeScale.title => switch (_textSize) {
        TextSize.small => theme.textTheme.titleSmall,
        TextSize.medium => theme.textTheme.titleMedium,
        TextSize.large => theme.textTheme.titleLarge,
      },
      TextTypeScale.headline => switch (_textSize) {
        TextSize.small => theme.textTheme.headlineSmall,
        TextSize.medium => theme.textTheme.headlineMedium,
        TextSize.large => theme.textTheme.headlineLarge,
      },
      TextTypeScale.display => switch (_textSize) {
        TextSize.small => theme.textTheme.displaySmall,
        TextSize.medium => theme.textTheme.displayMedium,
        TextSize.large => theme.textTheme.displayLarge,
      },
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      data,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      softWrap: softWrap,
      style: getStyle(theme)?.copyWith(
        color: fontColor,
        fontWeight: isBold ? FontWeight.bold : null,
        fontStyle: isItalic ? FontStyle.italic : null,
      ),
    );
  }
}
