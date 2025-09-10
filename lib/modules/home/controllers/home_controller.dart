import 'package:get/get.dart';
import '../../../services/kitchen_service.dart';
import '../../../data/models/order.dart';

class HomeController extends GetxController {
  HomeController(this.kitchenService);

  final KitchenService kitchenService;

  // Exposed streams / derived values for the view
  List<OrderModel> get pending => kitchenService.pending;
  List<OrderModel> get completed => kitchenService.completed;
  int get vipPending => kitchenService.vipQueue.length;
  int get normalPending => kitchenService.normalQueue.length;
  int get botsCount => kitchenService.bots.length;
  int get processingCount => kitchenService.processingCount;

  // UI actions
  void addNormalOrder() => kitchenService.addNormalOrder();
  void addVipOrder() => kitchenService.addVipOrder();

  void resetOrdersOnly() {
    kitchenService.vipQueue.clear();
    kitchenService.normalQueue.clear();
    kitchenService.completed.clear();
  }
}
