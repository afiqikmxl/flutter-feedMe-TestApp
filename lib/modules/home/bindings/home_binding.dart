import 'package:get/get.dart';
import '../../../services/kitchen_service.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(Get.find<KitchenService>()), fenix: true);
  }
}
