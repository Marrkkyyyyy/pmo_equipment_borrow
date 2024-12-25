import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmo_equipment_borrow/features_admin/auth/presentation/widgets/custom_auth_button.dart';
import 'package:pmo_equipment_borrow/features_admin/auth/presentation/widgets/custom_auth_prompt.dart';
import 'package:pmo_equipment_borrow/features_admin/auth/presentation/widgets/custom_auth_textfield.dart';
import 'package:pmo_equipment_borrow/features_admin/auth/presentation/widgets/custom_logo.dart';
import 'package:pmo_equipment_borrow/routes/routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CustomLogo(),
            const SizedBox(height: 40),
            const CustomAuthTextfield(
              labelText: 'Email',
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            const CustomAuthTextfield(
              labelText: 'Password',
              icon: Icons.lock,
              obscureText: true,
            ),
            const SizedBox(height: 20),
            CustomAuthButton(
                onPressed: () {
                  Get.toNamed(AppRoute.ADMIN_DASHBOARD_PAGE);
                },
                text: 'Login'),
            const SizedBox(height: 20),
            CustomAuthPrompt(
              message: "Don't have an account?",
              actionText: "Sign Up",
              onPressed: () {
                Get.toNamed(AppRoute.REGISTRATION_PAGE);
              },
            ),
          ],
        ),
      ),
    );
  }
}
