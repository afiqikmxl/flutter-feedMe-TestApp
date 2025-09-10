import 'package:flutter/material.dart';

class TabLabel extends StatelessWidget {
  final String title;
  final int count;
  final IconData icon;

  const TabLabel({super.key, required this.title, required this.count, required this.icon});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 6),
          Flexible(
              child: Text(title,
                  overflow: TextOverflow.ellipsis, style: t.titleSmall?.copyWith(fontWeight: FontWeight.w600))),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(color: Colors.black.withOpacity(.06), borderRadius: BorderRadius.circular(999)),
            child: Text('$count', style: t.labelLarge),
          ),
        ],
      ),
    );
  }
}
