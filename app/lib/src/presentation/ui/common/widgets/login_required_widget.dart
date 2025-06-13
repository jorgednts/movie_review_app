import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class LoginRequiredWidget extends StatelessWidget {
  const LoginRequiredWidget({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StackedIconCard(
        message: message,
        icon: Icons.lock_open,
        constraints: const BoxConstraints(maxWidth: 320),
      ),
    );
  }
}
