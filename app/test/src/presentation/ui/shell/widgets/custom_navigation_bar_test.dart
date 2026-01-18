import 'package:app/src/presentation/ui/common/widgets/app_logo_widget.dart';
import 'package:app/src/presentation/ui/shell/widgets/custom_navigation_bar.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:internationalization/internationalization.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'custom_navigation_bar_test.mocks.dart';

@GenerateMocks([StatefulNavigationShell])
void main() {
  group('CustomNavigationBar', () {
    late MockStatefulNavigationShell mockNavigationShell;

    setUp(() {
      mockNavigationShell = MockStatefulNavigationShell();
      when(mockNavigationShell.currentIndex).thenReturn(0);
    });

    Widget buildTestWidget({Size size = const Size(1000, 800)}) {
      return MaterialApp(
        localizationsDelegates: [AppIntl.delegate],
        supportedLocales: AppIntl.delegate.supportedLocales,
        home: MediaQuery(
          data: MediaQueryData(size: size),
          child: Scaffold(
            body: CustomNavigationBar(
              navigationShell: mockNavigationShell,
              authButton: const Text('Auth Button'),
            ),
          ),
        ),
      );
    }

    testWidgets('renders Desktop version when width > 750', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(size: const Size(1000, 800)));

      expect(find.byType(DefaultNavigationBar), findsOneWidget);
      expect(find.byType(DefaultNavigationMenu), findsOneWidget);
      expect(find.byType(AppLogoWidget), findsOneWidget);
      expect(find.text('Auth Button'), findsOneWidget);
    });

    testWidgets('renders Mobile version when width <= 750', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(size: const Size(600, 800)));

      expect(find.byType(DefaultNavigationBar), findsNothing);
      expect(find.byType(DefaultNavigationMenu), findsNothing);
      expect(find.byType(AppLogoWidget), findsOneWidget);
      expect(find.text('Auth Button'), findsOneWidget);
      
      // Mobile uses a Row
      expect(find.byType(Row), findsOneWidget);
    });

    testWidgets('clicking logo on desktop navigates to first branch', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(size: const Size(1000, 800)));

      await tester.tap(find.byType(AppLogoWidget));
      await tester.pump();

      verify(mockNavigationShell.goBranch(0)).called(1);
    });
  });
}
