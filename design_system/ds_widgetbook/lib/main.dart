import 'dart:ui';

import 'package:ds_widgetbook/src/cards/poster_card_component.dart';
import 'package:ds_widgetbook/src/lists/carousel_component.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:design_system/design_system.dart';

void main() {
  runApp(const DSWidgetbook());
}

class DSWidgetbook extends StatelessWidget {
  const DSWidgetbook({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      appBuilder:
          (context, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            scrollBehavior: const MaterialScrollBehavior().copyWith(
              dragDevices: PointerDeviceKind.values.toSet(),
            ),
            home: Material(child: child),
          ),
      addons: [
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(
              name: 'Light',
              data: CustomTheme.fromContext(context).light(),
            ),
            WidgetbookTheme(
              name: 'Dark',
              data: CustomTheme.fromContext(context).dark(),
            ),
          ],
        ),
      ],
      directories: [PosterCardComponent(), CarouselComponent()],
    );
  }
}
