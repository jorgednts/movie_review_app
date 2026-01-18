import 'package:app/src/domain/model/app_collection_item_model.dart';
import 'package:app/src/presentation/ui/common/widgets/review_bottom_sheet.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internationalization/internationalization.dart';

void main() {
  group('ReviewBottomSheet', () {
    final testItem = AppCollectionItemModel(
      type: AppCollectionItemType.movie,
      backdropPath: '/backdrop.jpg',
      tmdbId: 1,
      releaseDate: '2023-01-01',
      originalLanguage: 'en',
      overview: 'Test overview',
      posterPath: '/poster.jpg',
      title: 'Test Movie',
      voteAverage: 3.5,
      review: 'Initial review',
    );

    Widget buildTestWidget({required AppCollectionItemModel item}) {
      return MaterialApp(
        localizationsDelegates: [AppIntl.delegate],
        supportedLocales: AppIntl.delegate.supportedLocales,
        home: Scaffold(body: ReviewBottomSheet(item: item)),
      );
    }

    testWidgets('renders initial values correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestWidget(item: testItem));

      expect(find.text('Test Movie'), findsOneWidget);
      expect(find.text('Initial review'), findsOneWidget);
    });

    testWidgets('updates review text', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(item: testItem));

      await tester.enterText(
        find.byType(DefaultTextFormField),
        'New review content',
      );
      await tester.pump();

      expect(find.text('New review content'), findsOneWidget);
    });

    testWidgets('validation fails on empty review', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestWidget(item: testItem.copyWith(review: '')),
      );

      await tester.tap(find.byType(OutlinedButton));
      await tester.pump();
      expect(find.byType(Form), findsOneWidget);
    });
  });
}
