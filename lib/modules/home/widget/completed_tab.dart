import 'package:feedme/modules/home/controllers/home_controller.dart';
import 'package:feedme/modules/home/widget/order_card.dart';
import 'package:feedme/modules/shared/widgets/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompleteTab extends GetView<HomeController> {
  const CompleteTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final list = controller.completed;
      if (list.isEmpty) return const Center(child: EmptyState(message: 'No completed orders yet'));
      return ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: list.length,
        itemBuilder: (_, i) => OrderCard(order: list[i]),
      );
    });
  }
}
