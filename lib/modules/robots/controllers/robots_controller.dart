import 'package:get/get.dart';
import '../../../services/kitchen_service.dart';
import '../../../data/models/bot.dart';

class RobotsController extends GetxController {
  RobotsController(this.kitchenService);

  final KitchenService kitchenService;

  List<BotModel> get bots => kitchenService.bots;
  int get total => kitchenService.bots.length;
  int get processing => kitchenService.processingCount;
  int get idle => total - processing;

  void addBot() => kitchenService.addBot();
  void removeBot() => kitchenService.removeBot();
}
