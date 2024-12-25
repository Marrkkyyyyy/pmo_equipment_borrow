import 'package:flutter/material.dart';
import 'package:pmo_equipment_borrow/core/constant/app_images.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImages.logo,
      height: 200,
    );
  }
}
