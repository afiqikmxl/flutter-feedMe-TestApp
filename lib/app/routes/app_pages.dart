import 'package:get/get.dart';
import '../../modules/root/views/root_view.dart';
import '../../modules/home/bindings/home_binding.dart';
import '../../modules/home/views/home_view.dart';
import '../../modules/robots/bindings/robots_binding.dart';
import '../../modules/robots/views/robots_view.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.root;

  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.root,
      page: () => const RootView(),
      participatesInRootNavigator: true,
      bindings: [RobotsBinding(), HomeBinding(), RobotsBinding()],
      children: [
        GetPage(
          name: AppRoutes.home,
          page: () => const HomeView(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: AppRoutes.robots,
          page: () => const RobotsView(),
          binding: RobotsBinding(),
        ),
      ],
    ),
  ];
}
