import 'package:get/get.dart';
import '../../services/kitchen_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<KitchenService>(KitchenService(), permanent: true);
  }
}
