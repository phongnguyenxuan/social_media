import 'package:blog/modules/auth/login/login_view.dart';
import 'package:blog/modules/auth/register/register_binding.dart';
import 'package:blog/modules/auth/register/register_view.dart';
import 'package:blog/modules/main/main_binding.dart';
import 'package:blog/modules/main/main_view.dart';
import 'package:blog/routes/app_routes.dart';
import 'package:get/get.dart';

import '../modules/auth/login/login_binding.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: AppRoutes.LOGIN,
        page: () => const LoginView(),
        binding: LoginBinding()),
    GetPage(
        name: AppRoutes.REGISTER,
        page: () => const RegisterView(),
        binding: RegisterBinding()),
    GetPage(
        name: AppRoutes.MAIN,
        page: () => const MainView(),
        binding: MainBinding())
  ];
}