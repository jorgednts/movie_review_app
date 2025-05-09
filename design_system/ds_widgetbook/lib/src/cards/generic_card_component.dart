import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class GenericCardComponent extends WidgetbookComponent {
  GenericCardComponent()
      : super(
    name: 'Generic Card',
    useCases: [
      WidgetbookUseCase(
        name: "Card Genérico",
        builder: (context) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: GenericCard(
                      title: 'Exemplo Card',
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ],
  );

}