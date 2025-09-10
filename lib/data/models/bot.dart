import 'order.dart';

enum BotStatus { idle, processing }

class BotModel {
  final int id;
  BotStatus status;
  OrderModel? currentOrder;
  DateTime? startedAt;

  BotModel({
    required this.id,
    this.status = BotStatus.idle,
    this.currentOrder,
    this.startedAt,
  });
}
