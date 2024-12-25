import 'package:flutter/material.dart';
import 'package:pmo_equipment_borrow/core/theme/app_color.dart';

class CustomAuthPrompt extends StatelessWidget {
  final String message;
  final String actionText;
  final VoidCallback onPressed;

  const CustomAuthPrompt({
    super.key,
    required this.message,
    required this.actionText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(message),
        TextButton(
          onPressed: onPressed,
          child: Text(
            actionText,
            style: const TextStyle(color: AppColor.tealGreen),
          ),
        ),
      ],
    );
  }
}
