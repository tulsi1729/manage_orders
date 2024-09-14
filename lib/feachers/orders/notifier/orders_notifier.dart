import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manage_orders/error/console_log.dart';
import 'package:manage_orders/feachers/auth/notifiers/auth_notifier.dart';
import 'package:manage_orders/feachers/orders/repository/order_repository.dart';
import 'package:manage_orders/models/order_model.dart';

class OrdersNotifier extends FamilyAsyncNotifier<List<Order>, bool> {
  late OrderRepository _orderRepository;

  @override
  Future<List<Order>> build(bool arg) async {
    state = const AsyncLoading();
    return await getOrders();
  }

  Future<List<Order>> getOrders() async {
    final uid = (await ref.read(authProvider.future))!.uid;
    _orderRepository = ref.read(orderRepositoryProvider);
    final List<Order> orders = await _orderRepository.getUserOrders(uid, arg);
    return orders;
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    List<Order> orders = await getOrders();
    state = AsyncValue.data(orders);
  }

  Future<List<Order>> getUserOrders(uid) async {
    final uid = (await ref.read(authProvider.future))!.uid;

    List<Order> orders = await _orderRepository.getUserOrders(uid, arg);
    return orders;
  }

  void updateIsCompleted(Order order, bool isCompleted) async {
    final uid = (await ref.read(authProvider.future))!.uid;
    _orderRepository.updateIsCompleted(order, uid, isCompleted);
  }
}

final ordersProvider =
    AsyncNotifierProvider.family<OrdersNotifier, List<Order>, bool>(
        OrdersNotifier.new);

final upcomingOrdersProvider = ordersProvider(false);
final completedOrdersProvider = ordersProvider(true);
