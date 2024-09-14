import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manage_orders/feachers/orders/repository/order_repository.dart';
import 'package:manage_orders/models/order_model.dart';

class OrderNotifier extends Notifier<void> {
  late final OrderRepository _orderRepository;

  @override
  void build() {
    _orderRepository = ref.read(orderRepositoryProvider);
  }

  Future<bool> createOrder(Order order) async {
    final bool isOrderCreated = await _orderRepository.createOrder(order);
    return isOrderCreated;
  }

  Future<bool> editedOrder(Order editedOrder) async {
    List<Order> orders = [];
    int index = orders.indexWhere((order) => order.uid == editedOrder.uid);
    Order existing = orders.firstWhere((order) => order.uid == editedOrder.uid);
    orders.remove(existing);
    orders.insert(index, editedOrder);
    final bool isOrderEdited = await _orderRepository.editOrder(editedOrder);
    return isOrderEdited;
  }

  // Future<bool> deletedOrder(Order deletedOrder, WidgetRef ref) async {
  //   bool deleted = await _orderRepository.deletedOrder(deletedOrder);
  //   await ref.read(upcomingOrdersProvider.notifier).refresh();
  //   return deleted;
  // }
}

final orderProvider = NotifierProvider<OrderNotifier, void>(OrderNotifier.new);
