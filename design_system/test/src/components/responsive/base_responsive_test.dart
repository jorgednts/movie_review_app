import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:design_system/src/components/responsive/base_responsive.dart';

void main() {
  group('BaseResponsive', () {
    testWidgets('renders mobile widget when width is 750 or less',
            (WidgetTester tester) async {
          tester.view.physicalSize = const Size(750, 1000);
          tester.view.devicePixelRatio = 1.0;
          addTearDown(tester.view.reset);

          await tester.pumpWidget(
            const MaterialApp(
              home: BaseResponsive(
                mobile: Text('Mobile View'),
                desktop: Text('Desktop View'),
              ),
            ),
          );

          expect(find.text('Mobile View'), findsOneWidget);
          expect(find.text('Desktop View'), findsNothing);
        });

    testWidgets('renders desktop widget when width is greater than 750',
            (WidgetTester tester) async {
          tester.view.physicalSize = const Size(751, 1000);
          tester.view.devicePixelRatio = 1.0;
          addTearDown(tester.view.reset);

          await tester.pumpWidget(
            const MaterialApp(
              home: BaseResponsive(
                mobile: Text('Mobile View'),
                desktop: Text('Desktop View'),
              ),
            ),
          );

          expect(find.text('Desktop View'), findsOneWidget);
          expect(find.text('Mobile View'), findsNothing);
        });

    testWidgets('renders mobile widget for small screens',
            (WidgetTester tester) async {
          tester.view.physicalSize = const Size(375, 667); // iPhone SE size
          tester.view.devicePixelRatio = 1.0;
          addTearDown(tester.view.reset);

          await tester.pumpWidget(
            const MaterialApp(
              home: BaseResponsive(
                mobile: Text('Mobile View'),
                desktop: Text('Desktop View'),
              ),
            ),
          );

          expect(find.text('Mobile View'), findsOneWidget);
          expect(find.text('Desktop View'), findsNothing);
        });

    testWidgets('renders desktop widget for large screens',
            (WidgetTester tester) async {
          tester.view.physicalSize = const Size(1920, 1080); // Full HD
          tester.view.devicePixelRatio = 1.0;
          addTearDown(tester.view.reset);

          await tester.pumpWidget(
            const MaterialApp(
              home: BaseResponsive(
                mobile: Text('Mobile View'),
                desktop: Text('Desktop View'),
              ),
            ),
          );

          expect(find.text('Desktop View'), findsOneWidget);
          expect(find.text('Mobile View'), findsNothing);
        });

    testWidgets('handles complex mobile widget',
            (WidgetTester tester) async {
          tester.view.physicalSize = const Size(400, 800);
          tester.view.devicePixelRatio = 1.0;
          addTearDown(tester.view.reset);

          await tester.pumpWidget(
            const MaterialApp(
              home: BaseResponsive(
                mobile: Column(
                  children: [
                    Text('Mobile'),
                    Icon(Icons.phone_android),
                  ],
                ),
                desktop: Text('Desktop View'),
              ),
            ),
          );

          expect(find.text('Mobile'), findsOneWidget);
          expect(find.byIcon(Icons.phone_android), findsOneWidget);
          expect(find.text('Desktop View'), findsNothing);
        });

    testWidgets('handles complex desktop widget',
            (WidgetTester tester) async {
          tester.view.physicalSize = const Size(1024, 768);
          tester.view.devicePixelRatio = 1.0;
          addTearDown(tester.view.reset);

          await tester.pumpWidget(
            const MaterialApp(
              home: BaseResponsive(
                mobile: Text('Mobile View'),
                desktop: Row(
                  children: [
                    Text('Desktop'),
                    Icon(Icons.computer),
                  ],
                ),
              ),
            ),
          );

          expect(find.text('Desktop'), findsOneWidget);
          expect(find.byIcon(Icons.computer), findsOneWidget);
          expect(find.text('Mobile View'), findsNothing);
        });

    testWidgets('uses LayoutBuilder internally',
            (WidgetTester tester) async {
          tester.view.physicalSize = const Size(800, 600);
          tester.view.devicePixelRatio = 1.0;
          addTearDown(tester.view.reset);

          await tester.pumpWidget(
            const MaterialApp(
              home: BaseResponsive(
                mobile: Text('Mobile View'),
                desktop: Text('Desktop View'),
              ),
            ),
          );

          expect(find.byType(LayoutBuilder), findsOneWidget);
        });
  });
}