import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:design_system/src/components/buttons/segmented_switch_button.dart';

void main() {
  group('SegmentedSwitchButton', () {
    final segments = ['Option 1', 'Option 2', 'Option 3'];

    Widget buildTestWidget({
      required List<String> segments,
      required int initialIndex,
      bool showLabel = false,
      Function(String)? onSelectionChanged,
    }) {
      return MaterialApp(
        home: Scaffold(
          body: SegmentedSwitchButton<String>(
            segments: segments,
            iconBuilder: (s) => Icons.add,
            labelBuilder: (s) => s,
            initialIndex: initialIndex,
            showLabel: showLabel,
            onSelectionChanged: onSelectionChanged ?? (_) {},
          ),
        ),
      );
    }

    testWidgets('renders all segments as ButtonSegments', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(segments: segments, initialIndex: 0));

      expect(find.byType(Icon), findsNWidgets(3));
    });

    testWidgets('shows labels only when showLabel is true', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(segments: segments, initialIndex: 0, showLabel: false));
      expect(find.text('Option 1'), findsNothing);

      await tester.pumpWidget(buildTestWidget(segments: segments, initialIndex: 0, showLabel: true));
      expect(find.text('Option 1'), findsOneWidget);
      expect(find.text('Option 2'), findsOneWidget);
      expect(find.text('Option 3'), findsOneWidget);
    });

    testWidgets('initialIndex sets the correct initial selection', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(segments: segments, initialIndex: 1, showLabel: true));

      final segmentedButton = tester.widget<SegmentedButton<String>>(find.byType(SegmentedButton<String>));
      expect(segmentedButton.selected, contains('Option 2'));
    });

    testWidgets('tapping a segment triggers onSelectionChanged and updates selection', (WidgetTester tester) async {
      String? selectedSegment;
      await tester.pumpWidget(buildTestWidget(
        segments: segments,
        initialIndex: 0,
        showLabel: true,
        onSelectionChanged: (val) => selectedSegment = val,
      ));

      await tester.tap(find.text('Option 2'));
      await tester.pump();

      expect(selectedSegment, 'Option 2');

      final segmentedButton = tester.widget<SegmentedButton<String>>(find.byType(SegmentedButton<String>));
      expect(segmentedButton.selected, contains('Option 2'));
    });
  });
}
