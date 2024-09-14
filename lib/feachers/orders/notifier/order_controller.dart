// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:manage_orders/core/provider/storage_repository.dart';
// import 'package:manage_orders/core/provider/util.dart';
// import 'package:manage_orders/feachers/auth/notifiers/auth_notifier.dart';
// import 'package:manage_orders/feachers/orders/repository/order_repository.dart';
// import 'package:manage_orders/models/order_model.dart';
// import 'package:manage_orders/models/user_model.dart';
// import 'package:routemaster/routemaster.dart';
// import 'package:uuid/uuid.dart';

// final userOrdersProvider = StreamProvider((ref) {
//   final orderController = ref.watch(orderControllerProvider.notifier);
//   return orderController.getUserOrders();
// });

// final orderControllerProvider =
//     StateNotifierProvider<OrderController, bool>((ref) {
//   final orderRepository = ref.watch(orderRepositoryProvider);
//   final storageRepository = ref.watch(storageRepositoryProvider);

//   return OrderController(
//       orderRepository: orderRepository,
//       storageRepository: storageRepository,
//       ref: ref);
// });

// class OrderController extends StateNotifier<bool> {
//   final OrderRepository _orderRepository;
//   final Ref _ref;

//   OrderController(
//       {required OrderRepository orderRepository,
//       required Ref ref,
//       required StorageRepository storageRepository})
//       : _orderRepository = orderRepository,
//         _ref = ref,
//         super(false);

//   void createOrder(
//       String name, String address, String price, BuildContext context) async {
//     state = true;
//     final UserModel? userModel = await _ref.read(authProvider.future);

//     Order order = Order(
//       id: const Uuid().v4(),
//       name: name,
//       address: address,
//       price: double.tryParse(price) ?? 0,
//       time: DateTime.now(),
//       uid: userModel!.uid,
//       isCompleted: false,
//     );

//     final res = await _orderRepository.createOrder(order);
//     state = false;
//     res.fold((l) => showSnackBar(context, l.message), (r) {
//       showSnackBar(context, "Order created successfully!");
//       Routemaster.of(context).pop();
//     });
//   }

//   Stream<List<Order>> getUserOrders() {
//     // final uid = (await _ref.read(authProvider.future))!.uid;

//     return _orderRepository.getUserOrders("uid");
//   }

//   void updateIsCompleted(Order order, bool isCompleted) async {
//     final uid = (await _ref.read(authProvider.future))!.uid;
//     _orderRepository.updateIsCompleted(order, uid, isCompleted);
//   }
// }
