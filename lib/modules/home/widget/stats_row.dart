import 'package:flutter/material.dart';

class StatsRow extends StatelessWidget {
  final int vipPending;
  final int normalPending;
  final int bots;
  final int processing;
  final int completed;

  const StatsRow({
    super.key,
    required this.vipPending,
    required this.normalPending,
    required this.bots,
    required this.processing,
    required this.completed,
  });

  Chip statChip(String label, IconData icon) => Chip(avatar: Icon(icon, size: 18), label: Text(label));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          statChip('VIP: $vipPending', Icons.workspace_premium_outlined),
          statChip('Normal: $normalPending', Icons.people_outline),
          statChip('Bots: $bots', Icons.smart_toy_outlined),
          statChip('Processing: $processing', Icons.sync_outlined),
          statChip('Completed: $completed', Icons.check_circle_outline),
        ],
      ),
    );
  }
}
