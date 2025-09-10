import 'package:flutter/material.dart';
import '../../../data/models/order.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  const OrderCard({super.key, required this.order});

  Color badgeColor() {
    if (order.status == OrderStatus.complete) return const Color(0xFF2E7D32);
    return order.type == OrderType.vip ? const Color(0xFF6C4AB6) : const Color(0xFF607D8B);
  }

  String subtitle() {
    if (order.status == OrderStatus.complete) return 'Completed';
    return order.type == OrderType.vip ? 'VIP' : 'Normal';
  }

  Widget statusChip() {
    final label = switch (order.status) {
      OrderStatus.pending => 'Pending',
      OrderStatus.processing => 'Processing${order.pickedByBotId != null ? ' (Bot #${order.pickedByBotId})' : ''}',
      OrderStatus.complete => 'Complete',
    };
    return Chip(label: Text(label));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: badgeColor(),
          foregroundColor: Colors.white,
          child: Text('#${order.id}', style: const TextStyle(fontSize: 12)),
        ),
        title: Text('Order #${order.id}', style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle()),
        trailing: statusChip(),
      ),
    );
  }
}
