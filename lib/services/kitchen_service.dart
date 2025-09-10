import 'dart:async';
import 'package:feedme/core/constant/duration.dart';
import 'package:get/get.dart';
import '../data/models/order.dart';
import '../data/models/bot.dart';

/// KitchenService is the single source of truth:
/// - Holds queues, completed orders, and bots
/// - Applies priority rules (VIP before Normal)
/// - Simulates 10s processing time per order per bot
class KitchenService extends GetxService {
  // IDs
  int _nextOrderId = 1;
  int _nextBotId = 1;

  // Queues / state
  final vipQueue = <OrderModel>[].obs;
  final normalQueue = <OrderModel>[].obs;
  final completed = <OrderModel>[].obs;
  final bots = <BotModel>[].obs;

  // Timers per bot
  final Map<int, Timer> _activeTimers = {};

  // -----Add Orders -----
  void addNormalOrder() {
    normalQueue.add(OrderModel(id: _nextOrderId++, type: OrderType.normal));
    _assignWorkForIdleBots();
  }

  void addVipOrder() {
    vipQueue.add(OrderModel(id: _nextOrderId++, type: OrderType.vip));
    _assignWorkForIdleBots();
  }

  // ----- Add Bots -----
  void addBot() {
    final bot = BotModel(id: _nextBotId++);
    bots.add(bot);
    _assignWork(bot);
  }

  void removeBot() {
    if (bots.isEmpty) return;
    final bot = bots.removeLast();

    // Cancel processing if running
    _activeTimers.remove(bot.id)?.cancel();

    // If was processing, return order to front of its queue
    final order = bot.currentOrder;
    if (order != null) {
      order.status = OrderStatus.pending;
      order.pickedByBotId = null;
      if (order.type == OrderType.vip) {
        vipQueue.insert(0, order);
      } else {
        normalQueue.insert(0, order);
      }
    }
  }

  void resetAll() {
    for (final t in _activeTimers.values) {
      t.cancel();
    }
    _activeTimers.clear();
    vipQueue.clear();
    normalQueue.clear();
    completed.clear();
    bots.clear();
    _nextOrderId = 1;
    _nextBotId = 1;
  }

  // ----- Derived Data Using Get -----
  List<OrderModel> get pending => [...vipQueue, ...normalQueue];
  bool get hasPending => vipQueue.isNotEmpty || normalQueue.isNotEmpty;
  int get processingCount => bots.where((b) => b.status == BotStatus.processing).length;

  // ----- Scheduling Job For The Bots -----
  void _assignWorkForIdleBots() {
    for (final bot in bots) {
      if (bot.status == BotStatus.idle) {
        _assignWork(bot);
      }
    }
  }

  void _assignWork(BotModel bot) {
    if (!hasPending || bot.status == BotStatus.processing) {
      bot.status = BotStatus.idle;
      bot.currentOrder = null;
      bot.startedAt = null;
      bots.refresh();
      return;
    }

    OrderModel? order;
    if (vipQueue.isNotEmpty) {
      order = vipQueue.removeAt(0);
    } else if (normalQueue.isNotEmpty) {
      order = normalQueue.removeAt(0);
    }

    if (order == null) {
      bot.status = BotStatus.idle;
      bot.currentOrder = null;
      bot.startedAt = null;
      bots.refresh();
      return;
    }

    // Start processing
    bot.status = BotStatus.processing;
    bot.currentOrder = order;
    bot.startedAt = DateTime.now();
    order.status = OrderStatus.processing;
    order.pickedByBotId = bot.id;
    bots.refresh();

    // Simulate the 10s work
    final timer = Timer(DurationsConfig.orderProcess, () {
      // Bot might be removed mid-way
      if (!bots.any((b) => b.id == bot.id)) return;

      order!.status = OrderStatus.complete;
      order.completedAt = DateTime.now();
      completed.insert(0, order);

      bot.currentOrder = null;
      bot.status = BotStatus.idle;
      bot.startedAt = null;
      _activeTimers.remove(bot.id);
      bots.refresh();

      _assignWork(bot);
    });

    _activeTimers[bot.id] = timer;
  }

  @override
  void onClose() {
    for (final t in _activeTimers.values) {
      t.cancel();
    }
    _activeTimers.clear();
    super.onClose();
  }
}
