import 'package:feedme/modules/home/widget/completed_tab.dart';
import 'package:feedme/modules/home/widget/pending_tab.dart';
import 'package:feedme/modules/home/widget/stats_row.dart';
import 'package:feedme/modules/home/widget/tab_label.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Orders'),
          actions: [
            IconButton(
              tooltip: 'Reset orders',
              onPressed: controller.resetOrdersOnly,
              icon: const Icon(Icons.replay_outlined),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  FilledButton.icon(
                    onPressed: controller.addNormalOrder,
                    icon: const Icon(Icons.add_shopping_cart_outlined),
                    label: const Text('New Normal'),
                  ),
                  FilledButton.tonalIcon(
                    onPressed: controller.addVipOrder,
                    icon: const Icon(Icons.workspace_premium_outlined),
                    label: const Text('New VIP'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Obx(() => StatsRow(
                  vipPending: controller.vipPending,
                  normalPending: controller.normalPending,
                  bots: controller.botsCount,
                  processing: controller.processingCount,
                  completed: controller.completed.length,
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
              child: Obx(() {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: const Color(0xFFE8E6DE)),
                  ),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorPadding: const EdgeInsets.symmetric(horizontal: 40),
                    dividerColor: Colors.transparent,
                    tabs: [
                      TabLabel(title: 'Pending', count: controller.pending.length, icon: Icons.list_alt_outlined),
                      TabLabel(title: 'Complete', count: controller.completed.length, icon: Icons.check_circle_outline),
                    ],
                  ),
                );
              }),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFFE8E6DE)),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const TabBarView(
                      children: [
                        PendingTab(),
                        CompleteTab(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
