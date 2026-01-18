import 'package:app/src/presentation/ui/home/widgets/tmdb_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TMDBInfoCard', () {
    testWidgets('renders title, vote average, and release year correctly', (
      WidgetTester tester,
    ) async {
      const title = 'Interstellar';
      const voteAverage = 8.6;
      const releaseYear = '2014';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              height: 100,
              child: TMDBInfoCard(
                title: title,
                voteAverage: voteAverage,
                releaseYear: releaseYear,
              ),
            ),
          ),
        ),
      );

      expect(find.text(title), findsOneWidget);

      expect(find.text('8.6'), findsOneWidget);

      expect(find.text(releaseYear), findsOneWidget);

      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('release year has correct properties', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TMDBInfoCard(
              title: 'Test Movie',
              voteAverage: 7.0,
              releaseYear: '2023',
            ),
          ),
        ),
      );

      final yearWidget = tester.widget<Text>(find.text('2023'));
      expect(yearWidget.maxLines, 1);
    });
  });
}
