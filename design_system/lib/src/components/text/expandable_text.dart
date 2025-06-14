import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText({
    super.key,
    required this.text,
    required this.initLines,
    this.style,
    this.textAlign = TextAlign.justify,
    required this.seeMore,
    required this.seeLess,
  });

  final String text;
  final TextStyle? style;
  final int initLines;
  final TextAlign textAlign;
  final String seeMore;
  final String seeLess;

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SelectableText(
          widget.text,
          textAlign: widget.textAlign,
          maxLines: isExpanded ? null : widget.initLines,
          style: widget.style,
        ),
        TextButton(
          onPressed:
              () => setState(() {
                isExpanded = !isExpanded;
              }),
          child: StyledText.b1(isExpanded ? widget.seeLess : widget.seeMore),
        ),
      ],
    );
  }
}
