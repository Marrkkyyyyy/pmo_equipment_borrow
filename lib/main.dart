import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pmo_equipment_borrow/core/constant/app_strings.dart';
import 'package:pmo_equipment_borrow/core/services/http_override_service.dart';
import 'package:pmo_equipment_borrow/core/theme/app_theme.dart';
import 'package:pmo_equipment_borrow/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrideService.initialize();
  // await Firebase.initializeApp(
  //   options: FirebaseOptionsManager.getOptions(isProduction: false),
  // );

  // await DependencyInjection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoute.LOGIN_PAGE,
      getPages: AppPages.routes,
      builder: EasyLoading.init(),
    );
  }
}
