import 'package:feedme/core/constant/duration.dart';
import 'package:flutter/material.dart';
import '../../../data/models/bot.dart';

class BotTile extends StatelessWidget {
  final BotModel bot;
  const BotTile({super.key, required this.bot});

  @override
  Widget build(BuildContext context) {
    final isIdle = bot.status == BotStatus.idle;
    final text = isIdle ? 'Idle' : 'Processing order #${bot.currentOrder?.id ?? '—'}';

    Widget progress() {
      if (isIdle) return const SizedBox.shrink();
      // Restart the animation when a new order attaches to this bot
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: TweenAnimationBuilder<double>(
          key: ValueKey('bot${bot.id}-order${bot.currentOrder?.id}'),
          tween: Tween(begin: 0, end: 1),
          duration: DurationsConfig.orderProcess,
          builder: (_, v, __) => ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(value: v, minHeight: 6),
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            const CircleAvatar(child: Icon(Icons.smart_toy, size: 18)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Bot #${bot.id}', style: const TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 2),
                  Text(text, maxLines: 1, overflow: TextOverflow.ellipsis),
                  progress(),
                ],
              ),
            ),
            const SizedBox(width: 8),
            StatusChip(status: bot.status),
          ],
        ),
      ),
    );
  }
}

class StatusChip extends StatelessWidget {
  final BotStatus status;
  const StatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final String label;
    final Color color;
    switch (status) {
      case BotStatus.idle:
        label = 'Idle';
        color = Colors.grey.shade600;
        break;
      case BotStatus.processing:
        label = 'Processing';
        color = Colors.orange.shade800;
        break;
    }
    return Chip(
      label: Text(label),
      labelStyle: const TextStyle(fontWeight: FontWeight.w600),
      side: BorderSide(color: color.withOpacity(.3)),
    );
  }
}
