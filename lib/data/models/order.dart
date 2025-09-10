enum OrderType { normal, vip }
enum OrderStatus { pending, processing, complete }

class OrderModel {
  final int id;
  final OrderType type;
  OrderStatus status;
  int? pickedByBotId;
  final DateTime createdAt;
  DateTime? completedAt;

  OrderModel({
    required this.id,
    required this.type,
    this.status = OrderStatus.pending,
    this.pickedByBotId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}
