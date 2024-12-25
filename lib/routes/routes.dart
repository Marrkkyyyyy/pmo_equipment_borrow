import 'package:get/get.dart';
import 'package:pmo_equipment_borrow/features_admin/auth/presentation/pages/login.dart';
import 'package:pmo_equipment_borrow/features_admin/auth/presentation/pages/registration.dart';
import 'package:pmo_equipment_borrow/features_admin/borrow/presentation/controllers/manage_borrowing_controller.dart';
import 'package:pmo_equipment_borrow/features_admin/borrow/presentation/pages/manage_borrowing.dart';
import 'package:pmo_equipment_borrow/features_admin/equipment/presentation/controllers/manage_equipment_controller.dart';
import 'package:pmo_equipment_borrow/features_admin/equipment/presentation/pages/manage_equipment.dart';
import 'package:pmo_equipment_borrow/features_admin/home/presentation/pages/admin_dashboard.dart';
import 'package:pmo_equipment_borrow/features_admin/user/presentation/pages/manage_users.dart';
import 'package:pmo_equipment_borrow/features_user/home/presentation/pages/user_dashboard.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoute.LOGIN_PAGE,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: AppRoute.REGISTRATION_PAGE,
      page: () => const RegistrationPage(),
    ),
    GetPage(
      name: AppRoute.ADMIN_DASHBOARD_PAGE,
      page: () => const AdminDashboardPage(),
    ),
    GetPage(
      name: AppRoute.MANAGE_USERS_PAGE,
      page: () => const ManageUsersPage(),
    ),
    GetPage(
      name: AppRoute.MANAGE_BORROWING_PAGE,
      page: () => const ManageBorrowingPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ManageBorrowingController>(
            () => ManageBorrowingController());
      }),
    ),
    GetPage(
      name: AppRoute.MANAGE_EQUIPMENT_PAGE,
      page: () => const ManageEquipment(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ManageEquipmentController>(
            () => ManageEquipmentController());
      }),
    ),

    // regular user

    GetPage(
      name: AppRoute.USER_DASHBOARD_PAGE,
      page: () => const UserDashboardPage(),
    ),

    // GetPage(
    //   name: AppRoute.TRACK_PACKAGE,
    //   page: () => const TrackPackage(),
    //   binding: BindingsBuilder(() {
    //     Get.lazyPut<TrackPackageController>(() => TrackPackageController(
    //           Get.find<TrackPackageRepository>(),
    //           Get.find<ClientService>(),
    //         ));
    //   }),
    // ),
    // GetPage(
    //   name: AppRoute.REGISTRATION_PAGE,
    //   page: () => const RegistrationPage(),
    //   binding: BindingsBuilder(() {
    //     Get.lazyPut<RegistrationController>(() => RegistrationController(
    //         Get.find<SharedPreferencesService>(),
    //         Get.find<RegistrationRepository>()));
    //   }),
    // ),
  ];
}

abstract class AppRoute {
  static const LOGIN_PAGE = '/';
  static const REGISTRATION_PAGE = '/REGISTRATION_PAGE';
  static const ADMIN_DASHBOARD_PAGE = '/ADMIN_DASHBOARD_PAGE';

  //
  static const MANAGE_BORROWING_PAGE = '/MANAGE_BORROWING_PAGE';

  //
  static const MANAGE_EQUIPMENT_PAGE = '/MANAGE_EQUIPMENT_PAGE';

  //
  static const MANAGE_USERS_PAGE = '/MANAGE_USERS_PAGE';

  // regular user
  static const USER_DASHBOARD_PAGE = '/USER_DASHBOARD_PAGE';
}
