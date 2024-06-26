import 'package:blog/modules/auth/login/login_view.dart';
import 'package:blog/modules/auth/register/register_binding.dart';
import 'package:blog/modules/auth/register/register_view.dart';
import 'package:blog/modules/auth/forgot_password/forgot_binding.dart';
import 'package:blog/modules/auth/forgot_password/forgot_view.dart';
import 'package:blog/modules/home/create_post/create_post_view.dart';
import 'package:blog/modules/home/home_binding.dart';
import 'package:blog/modules/home/home_view.dart';
import 'package:blog/modules/main/main_binding.dart';
import 'package:blog/modules/main/main_view.dart';
import 'package:blog/modules/splash/splash_binding.dart';
import 'package:blog/modules/splash/splash_view.dart';
import 'package:blog/routes/app_routes.dart';
import 'package:get/get.dart';

import '../modules/auth/login/login_binding.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
        name: AppRoutes.MAIN,
        page: () => const MainView(),
        binding: MainBinding(),
        children: [
          GetPage(
            name: AppRoutes.HOME,
            page: () => const HomeView(),
            binding: HomeBinding(),
          )
        ]),
    GetPage(
      name: AppRoutes.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.CREATE_POST,
      page: () => const CreatePostView(),
      binding: ForgotPasswordBinding(),
    ),
  ];
}
