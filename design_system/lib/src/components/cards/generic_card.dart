import 'package:flutter/material.dart';

class GenericCard extends StatelessWidget {
  const GenericCard({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            Container(),
            Container(),
          ],
        ),
      ),
    );
  }
}
