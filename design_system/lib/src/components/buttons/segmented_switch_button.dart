import 'package:flutter/material.dart';

class SegmentedSwitchButton<T> extends StatefulWidget {
  final List<T> segments;
  final IconData Function(T segment) iconBuilder;
  final String Function(T segment) labelBuilder;
  final void Function(T segment) onSelectionChanged;
  final bool showLabel;
  final int initialIndex;

  const SegmentedSwitchButton({
    super.key,
    required this.segments,
    required this.iconBuilder,
    required this.labelBuilder,
    required this.onSelectionChanged,
    required this.initialIndex,
    this.showLabel = false,
  });

  @override
  State<SegmentedSwitchButton<T>> createState() =>
      _SegmentedSwitchButtonState<T>();
}

class _SegmentedSwitchButtonState<T> extends State<SegmentedSwitchButton<T>> {
  int selectedIndex = 0;

  @override
  void initState() {
    selectedIndex = widget.initialIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<T>(
      segments:
          widget.segments
              .map(
                (segment) => ButtonSegment<T>(
                  value: segment,
                  icon: Icon(widget.iconBuilder(segment)),
                  label:
                      widget.showLabel
                          ? Text(widget.labelBuilder(segment))
                          : null,
                  tooltip: widget.labelBuilder(segment),
                ),
              )
              .toList(),
      selected: {widget.segments[selectedIndex]},
      showSelectedIcon: false,
      multiSelectionEnabled: false,
      emptySelectionAllowed: false,
      onSelectionChanged: (selection) {
        setState(() {
          selectedIndex = widget.segments.indexOf(selection.first);
          widget.onSelectionChanged(widget.segments[selectedIndex]);
        });
      },
    );
  }
}
