import 'package:get/get.dart';
import '../../../services/kitchen_service.dart';
import '../controllers/robots_controller.dart';

class RobotsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RobotsController(Get.find<KitchenService>()), fenix: true);
  }
}
