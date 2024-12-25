import 'package:flutter/material.dart';
import 'package:pmo_equipment_borrow/core/constant/app_strings.dart';
import 'package:pmo_equipment_borrow/core/theme/app_color.dart';
import 'package:get/get.dart';
import 'package:pmo_equipment_borrow/features_admin/auth/presentation/widgets/custom_auth_button.dart';
import 'package:pmo_equipment_borrow/features_admin/auth/presentation/widgets/custom_auth_dropdown.dart';
import 'package:pmo_equipment_borrow/features_admin/auth/presentation/widgets/custom_auth_prompt.dart';
import 'package:pmo_equipment_borrow/features_admin/auth/presentation/widgets/custom_auth_textfield.dart';
import 'package:pmo_equipment_borrow/features_admin/auth/presentation/widgets/custom_logo.dart';
import 'package:pmo_equipment_borrow/routes/routes.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: AppColor.navyBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CustomLogo(),
            const SizedBox(height: 30),
            const CustomAuthTextfield(
                labelText: 'First Name', icon: Icons.person),
            const SizedBox(height: 20),
            const CustomAuthTextfield(
                labelText: 'Last Name', icon: Icons.person),
            const SizedBox(height: 20),
            const CustomAuthTextfield(
                labelText: 'School ID', icon: Icons.badge),
            const SizedBox(height: 20),
            const CustomAuthTextfield(
                labelText: 'Email',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 20),
            const CustomAuthTextfield(
                labelText: 'Password', icon: Icons.lock, obscureText: true),
            const SizedBox(height: 20),
            const CustomAuthDropdown(
                items: AppStrings.departments, labelText: 'Department'),
            const SizedBox(height: 20),
            CustomAuthButton(
                onPressed: () {
                  Get.toNamed(AppRoute.USER_DASHBOARD_PAGE);
                },
                text: 'Register'),
            const SizedBox(height: 20),
            CustomAuthPrompt(
              message: "Already have an account?",
              actionText: "Login",
              onPressed: () {
                Get.toNamed(AppRoute.LOGIN_PAGE);
              },
            ),
          ],
        ),
      ),
    );
  }
}
