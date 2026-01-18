import 'package:design_system/src/components/text/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StyledText', () {
    testWidgets('renders correctly with default values', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: StyledText.b2('Hello World'))),
      );

      final textFinder = find.text('Hello World');
      expect(textFinder, findsOneWidget);

      final textWidget = tester.widget<Text>(textFinder);
      expect(textWidget.style?.fontWeight, isNot(FontWeight.bold));
      expect(textWidget.style?.fontStyle, isNot(FontStyle.italic));
    });

    testWidgets('applies bold and italic styles', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StyledText.b2('Styled', isBold: true, isItalic: true),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Styled'));
      expect(textWidget.style?.fontWeight, FontWeight.bold);
      expect(textWidget.style?.fontStyle, FontStyle.italic);
    });

    testWidgets('applies custom font color', (WidgetTester tester) async {
      const customColor = Colors.red;
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StyledText.b2('Colored', fontColor: customColor),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Colored'));
      expect(textWidget.style?.color, customColor);
    });

    testWidgets('respects text properties like maxLines and textAlign', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StyledText.b2(
              'Properties',
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Properties'));
      expect(textWidget.maxLines, 2);
      expect(textWidget.textAlign, TextAlign.center);
      expect(textWidget.overflow, TextOverflow.ellipsis);
    });

    testWidgets('respects softWrap property', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StyledText.b2('Soft wrap test', softWrap: false),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Soft wrap test'));
      expect(textWidget.softWrap, false);
    });

    testWidgets('renders different scale variants correctly (e.g., h1)', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            textTheme: const TextTheme(
              headlineSmall: TextStyle(fontSize: 24.0),
            ),
          ),
          home: const Scaffold(body: StyledText.h1('Headline')),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Headline'));
      expect(textWidget.style?.fontSize, 24.0);
    });

    group('Label variants', () {
      testWidgets('l1 uses labelSmall style', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              textTheme: const TextTheme(labelSmall: TextStyle(fontSize: 11.0)),
            ),
            home: const Scaffold(body: StyledText.l1('Label Small')),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Label Small'));
        expect(textWidget.style?.fontSize, 11.0);
      });

      testWidgets('l2 uses labelMedium style', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              textTheme: const TextTheme(
                labelMedium: TextStyle(fontSize: 12.0),
              ),
            ),
            home: const Scaffold(body: StyledText.l2('Label Medium')),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Label Medium'));
        expect(textWidget.style?.fontSize, 12.0);
      });

      testWidgets('l3 uses labelLarge style', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              textTheme: const TextTheme(labelLarge: TextStyle(fontSize: 14.0)),
            ),
            home: const Scaffold(body: StyledText.l3('Label Large')),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Label Large'));
        expect(textWidget.style?.fontSize, 14.0);
      });
    });

    group('Body variants', () {
      testWidgets('b1 uses bodySmall style', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              textTheme: const TextTheme(bodySmall: TextStyle(fontSize: 12.0)),
            ),
            home: const Scaffold(body: StyledText.b1('Body Small')),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Body Small'));
        expect(textWidget.style?.fontSize, 12.0);
      });

      testWidgets('b2 uses bodyMedium style', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 14.0)),
            ),
            home: const Scaffold(body: StyledText.b2('Body Medium')),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Body Medium'));
        expect(textWidget.style?.fontSize, 14.0);
      });

      testWidgets('b3 uses bodyLarge style', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              textTheme: const TextTheme(bodyLarge: TextStyle(fontSize: 16.0)),
            ),
            home: const Scaffold(body: StyledText.b3('Body Large')),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Body Large'));
        expect(textWidget.style?.fontSize, 16.0);
      });
    });

    group('Title variants', () {
      testWidgets('t1 uses titleSmall style', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              textTheme: const TextTheme(titleSmall: TextStyle(fontSize: 14.0)),
            ),
            home: const Scaffold(body: StyledText.t1('Title Small')),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Title Small'));
        expect(textWidget.style?.fontSize, 14.0);
      });

      testWidgets('t2 uses titleMedium style', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              textTheme: const TextTheme(
                titleMedium: TextStyle(fontSize: 16.0),
              ),
            ),
            home: const Scaffold(body: StyledText.t2('Title Medium')),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Title Medium'));
        expect(textWidget.style?.fontSize, 16.0);
      });

      testWidgets('t3 uses titleLarge style', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              textTheme: const TextTheme(titleLarge: TextStyle(fontSize: 22.0)),
            ),
            home: const Scaffold(body: StyledText.t3('Title Large')),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Title Large'));
        expect(textWidget.style?.fontSize, 22.0);
      });
    });

    group('Headline variants', () {
      testWidgets('h1 uses headlineSmall style', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              textTheme: const TextTheme(
                headlineSmall: TextStyle(fontSize: 24.0),
              ),
            ),
            home: const Scaffold(body: StyledText.h1('Headline Small')),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Headline Small'));
        expect(textWidget.style?.fontSize, 24.0);
      });

      testWidgets('h2 uses headlineMedium style', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              textTheme: const TextTheme(
                headlineMedium: TextStyle(fontSize: 28.0),
              ),
            ),
            home: const Scaffold(body: StyledText.h2('Headline Medium')),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Headline Medium'));
        expect(textWidget.style?.fontSize, 28.0);
      });

      testWidgets('h3 uses headlineLarge style', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              textTheme: const TextTheme(
                headlineLarge: TextStyle(fontSize: 32.0),
              ),
            ),
            home: const Scaffold(body: StyledText.h3('Headline Large')),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Headline Large'));
        expect(textWidget.style?.fontSize, 32.0);
      });
    });

    group('Display variants', () {
      testWidgets('d1 uses displaySmall style', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              textTheme: const TextTheme(
                displaySmall: TextStyle(fontSize: 36.0),
              ),
            ),
            home: const Scaffold(body: StyledText.d1('Display Small')),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Display Small'));
        expect(textWidget.style?.fontSize, 36.0);
      });

      testWidgets('d2 uses displayMedium style', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              textTheme: const TextTheme(
                displayMedium: TextStyle(fontSize: 45.0),
              ),
            ),
            home: const Scaffold(body: StyledText.d2('Display Medium')),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Display Medium'));
        expect(textWidget.style?.fontSize, 45.0);
      });

      testWidgets('d3 uses displayLarge style', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              textTheme: const TextTheme(
                displayLarge: TextStyle(fontSize: 57.0),
              ),
            ),
            home: const Scaffold(body: StyledText.d3('Display Large')),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Display Large'));
        expect(textWidget.style?.fontSize, 57.0);
      });
    });

    group('Style combinations', () {
      testWidgets('combines bold, italic, and color', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: StyledText.b2(
                'Combined',
                isBold: true,
                isItalic: true,
                fontColor: Colors.blue,
              ),
            ),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Combined'));
        expect(textWidget.style?.fontWeight, FontWeight.bold);
        expect(textWidget.style?.fontStyle, FontStyle.italic);
        expect(textWidget.style?.color, Colors.blue);
      });

      testWidgets('combines all text properties', (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: StyledText.h2(
                'Full combo',
                isBold: true,
                isItalic: true,
                fontColor: Colors.green,
                maxLines: 3,
                textAlign: TextAlign.right,
                overflow: TextOverflow.fade,
                softWrap: true,
              ),
            ),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Full combo'));
        expect(textWidget.style?.fontWeight, FontWeight.bold);
        expect(textWidget.style?.fontStyle, FontStyle.italic);
        expect(textWidget.style?.color, Colors.green);
        expect(textWidget.maxLines, 3);
        expect(textWidget.textAlign, TextAlign.right);
        expect(textWidget.overflow, TextOverflow.fade);
        expect(textWidget.softWrap, true);
      });
    });

    group('Edge cases', () {
      testWidgets('handles empty string', (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: StyledText.b2(''))),
        );

        expect(find.text(''), findsOneWidget);
      });

      testWidgets('handles very long text', (WidgetTester tester) async {
        final longText =
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. ' * 10;
        await tester.pumpWidget(
          MaterialApp(home: Scaffold(body: StyledText.b2(longText))),
        );

        expect(find.text(longText), findsOneWidget);
      });

      testWidgets('handles special characters', (WidgetTester tester) async {
        const specialText = '!@#\$%^&*()_+-=[]{}|;:,.<>?/~`';
        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: StyledText.b2(specialText))),
        );

        expect(find.text(specialText), findsOneWidget);
      });

      testWidgets('handles unicode and emojis', (WidgetTester tester) async {
        const emojiText = 'Hello 👋 World 🌍';
        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: StyledText.b2(emojiText))),
        );

        expect(find.text(emojiText), findsOneWidget);
      });
    });
  });
}
