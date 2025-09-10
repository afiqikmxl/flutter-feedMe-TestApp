import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/widgets/empty_state.dart';
import '../controllers/robots_controller.dart';
import '../widgets/bot_tile.dart';

class RobotsView extends GetView<RobotsController> {
  const RobotsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Robots')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                OutlinedButton.icon(
                  onPressed: controller.addBot,
                  icon: const Icon(Icons.smart_toy_outlined),
                  label: const Text('Add Bot'),
                ),
                OutlinedButton.icon(
                  onPressed: controller.removeBot,
                  icon: const Icon(Icons.smart_toy),
                  label: const Text('Remove Bot'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Obx(() {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  Chip(
                      avatar: const Icon(Icons.smart_toy_outlined, size: 18),
                      label: Text('Total: ${controller.total}')),
                  Chip(
                      avatar: const Icon(Icons.sync_outlined, size: 18),
                      label: Text('Processing: ${controller.processing}')),
                  Chip(
                      avatar: const Icon(Icons.pause_circle_outline, size: 18),
                      label: Text('Idle: ${controller.idle}')),
                ],
              ),
            );
          }),
          const SizedBox(height: 8),
          Expanded(
            child: Obx(() {
              final list = controller.bots;
              if (list.isEmpty) return const Center(child: EmptyState(message: 'No bots yet — add one!'));
              return ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: list.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (_, i) => BotTile(bot: list[i]),
              );
            }),
          ),
        ],
      ),
    );
  }
}
