import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PosterCard', () {
    const posterUrl = 'https://example.com/poster.jpg';
    const infoText = 'Movie Info';

    Widget buildTestWidget({
      String url = posterUrl,
      Widget info = const Text(infoText),
      Widget? placeholder,
      double? height,
      double? width,
      double? borderRadius,
      BoxFit? boxFit,
    }) {
      return MaterialApp(
        home: Scaffold(
          body: SizedBox(
            height: 400,
            width: 300,
            child: PosterCard(
              posterUrl: url,
              infoWidget: info,
              placeholder: placeholder,
              height: height,
              width: width,
              borderRadius: borderRadius ?? Dimensions.radiusMd,
              boxFit: boxFit ?? BoxFit.scaleDown,
            ),
          ),
        ),
      );
    }

    testWidgets('renders CustomNetworkImage and infoWidget', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());

      expect(find.byType(CustomNetworkImage), findsOneWidget);
      expect(find.text(infoText), findsOneWidget);

      final networkImage = tester.widget<CustomNetworkImage>(
        find.byType(CustomNetworkImage),
      );
      expect(networkImage.url, posterUrl);
    });

    testWidgets('applies borderRadius to image and info container', (
      WidgetTester tester,
    ) async {
      const customRadius = 20.0;
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 400,
              width: 300,
              child: PosterCard(
                posterUrl: posterUrl,
                infoWidget: Text(infoText),
                borderRadius: customRadius,
              ),
            ),
          ),
        ),
      );

      final clipRRect = tester.widget<ClipRRect>(find.byType(ClipRRect));
      expect(
        clipRRect.borderRadius,
        const BorderRadius.only(
          topLeft: Radius.circular(customRadius),
          topRight: Radius.circular(customRadius),
        ),
      );

      final container = tester.widget<Container>(
        find.ancestor(
          of: find.text(infoText),
          matching: find.byType(Container),
        ),
      );
      final decoration = container.decoration as BoxDecoration;
      expect(
        decoration.borderRadius,
        const BorderRadius.only(
          bottomLeft: Radius.circular(customRadius),
          bottomRight: Radius.circular(customRadius),
        ),
      );
    });

    testWidgets('uses default borderRadius when not provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());

      final clipRRect = tester.widget<ClipRRect>(find.byType(ClipRRect));
      expect(
        clipRRect.borderRadius,
        const BorderRadius.only(
          topLeft: Radius.circular(Dimensions.radiusMd),
          topRight: Radius.circular(Dimensions.radiusMd),
        ),
      );
    });

    testWidgets('uses DefaultErrorWidget for error state', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());

      final networkImage = tester.widget<CustomNetworkImage>(
        find.byType(CustomNetworkImage),
      );
      expect(networkImage.errorWidget, isNotNull);
      expect(networkImage.errorWidget, isA<Center>());
    });

    testWidgets('applies correct flex values for image and info', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());

      final expandedWidgets =
          tester.widgetList<Expanded>(find.byType(Expanded)).toList();

      expect(expandedWidgets.length, 2);
      expect(expandedWidgets[0].flex, PosterCard.posterImageFlex);
      expect(expandedWidgets[1].flex, PosterCard.posterInfoFlex);
    });

    testWidgets('posterImageFlex and posterInfoFlex have correct values', (
      WidgetTester tester,
    ) async {
      expect(PosterCard.posterImageFlex, 750);
      expect(PosterCard.posterInfoFlex, 250);
    });

    testWidgets('posterImageProportion is calculated correctly', (
      WidgetTester tester,
    ) async {
      const expectedProportion = 750 / 1000;
      expect(PosterCard.posterImageProportion, expectedProportion);
      expect(PosterCard.posterImageProportion, 0.75);
    });

    testWidgets('passes height and width to CustomNetworkImage', (
      WidgetTester tester,
    ) async {
      const customHeight = 500.0;
      const customWidth = 350.0;

      await tester.pumpWidget(
        buildTestWidget(height: customHeight, width: customWidth),
      );

      final networkImage = tester.widget<CustomNetworkImage>(
        find.byType(CustomNetworkImage),
      );
      expect(networkImage.height, customHeight);
      expect(networkImage.width, customWidth);
    });

    testWidgets('uses BoxFit.cover for image by default', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());

      final networkImage = tester.widget<CustomNetworkImage>(
        find.byType(CustomNetworkImage),
      );
      expect(networkImage.boxFit, BoxFit.cover);
    });

    testWidgets('info container has correct padding', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());

      final container = tester.widget<Container>(
        find.ancestor(
          of: find.text(infoText),
          matching: find.byType(Container),
        ),
      );

      expect(container.padding, const EdgeInsets.all(Dimensions.spacingSm));
    });

    testWidgets('info container spans full width', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget());

      final container = tester.widget<Container>(
        find.ancestor(
          of: find.text(infoText),
          matching: find.byType(Container),
        ),
      );

      expect(container.constraints?.maxWidth, double.infinity);
    });

    testWidgets('info container has correct background color', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());

      final container = tester.widget<Container>(
        find.ancestor(
          of: find.text(infoText),
          matching: find.byType(Container),
        ),
      );

      final decoration = container.decoration as BoxDecoration;
      final theme = Theme.of(tester.element(find.byType(PosterCard)));

      expect(decoration.color, theme.colorScheme.surfaceContainerHigh);
    });

    testWidgets('renders complex infoWidget', (WidgetTester tester) async {
      final complexInfo = const Column(
        children: [Text('Title'), Text('Subtitle'), Icon(Icons.star)],
      );

      await tester.pumpWidget(buildTestWidget(info: complexInfo));

      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Subtitle'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('Column uses correct structure', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget());

      final column = tester.widget<Column>(find.byType(Column).first);
      expect(column.children.length, 2);
      expect(column.children[0], isA<Expanded>());
      expect(column.children[1], isA<Expanded>());
    });

    group('Border radius edge cases', () {
      testWidgets('works with zero border radius', (WidgetTester tester) async {
        await tester.pumpWidget(buildTestWidget(borderRadius: 0));

        final clipRRect = tester.widget<ClipRRect>(find.byType(ClipRRect));
        expect(
          clipRRect.borderRadius,
          const BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
          ),
        );
      });

      testWidgets('works with large border radius', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(buildTestWidget(borderRadius: 50));

        final clipRRect = tester.widget<ClipRRect>(find.byType(ClipRRect));
        expect(
          clipRRect.borderRadius,
          const BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        );
      });
    });

    group('URL variations', () {
      testWidgets('handles different URL formats', (WidgetTester tester) async {
        const urls = [
          'https://example.com/image.jpg',
          'https://example.com/image.png',
          'http://example.com/image.webp',
        ];

        for (final url in urls) {
          await tester.pumpWidget(buildTestWidget(url: url));

          final networkImage = tester.widget<CustomNetworkImage>(
            find.byType(CustomNetworkImage),
          );
          expect(networkImage.url, url);
        }
      });
    });

    group('Proportions', () {
      testWidgets('image section takes 75% of total height', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(buildTestWidget());

        final proportion =
            PosterCard.posterImageFlex /
            (PosterCard.posterImageFlex + PosterCard.posterInfoFlex);
        expect(proportion, 0.75);
      });

      testWidgets('info section takes 25% of total height', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(buildTestWidget());

        final proportion =
            PosterCard.posterInfoFlex /
            (PosterCard.posterImageFlex + PosterCard.posterInfoFlex);
        expect(proportion, 0.25);
      });
    });

    testWidgets('renders correctly without height and width parameters', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());

      final networkImage = tester.widget<CustomNetworkImage>(
        find.byType(CustomNetworkImage),
      );
      expect(networkImage.height, isNull);
      expect(networkImage.width, isNull);
    });
  });
}
