import 'package:flutter/material.dart';
import 'package:pmo_equipment_borrow/core/theme/app_color.dart';

class CustomAuthTextfield extends StatelessWidget {
  const CustomAuthTextfield(
      {super.key,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      required this.labelText,
      required this.icon});
  final String labelText;
  final TextInputType keyboardType;
  final IconData icon;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: AppColor.tealGreen),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      keyboardType: keyboardType,
    );
  }
}
