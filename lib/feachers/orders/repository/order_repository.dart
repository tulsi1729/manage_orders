import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manage_orders/core/constant/firebase_constant.dart';
import 'package:manage_orders/core/provider/firebase_provider.dart';
import 'package:manage_orders/models/order_model.dart' as model;

final orderRepositoryProvider = Provider((ref) {
  return OrderRepository(firestore: ref.watch(firestoreProvider));
});

class OrderRepository {
  final FirebaseFirestore _firestore;

  OrderRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Future<bool> createOrder(model.Order order) async {
    try {
      final orderDoc = await _orders.doc(order.id).get();
      if (orderDoc.exists) {
        throw 'Order with the same name already exists!';
      }
      await _orders.doc(order.id).set(order.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> editOrder(model.Order order) async {
    try {
      await _orders.doc(order.id).get();
      await _orders.doc(order.id).set(order.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  // Future<bool> deletedOrder(model.Order order) async {
  //   try {
  //     consoleLog("i am here $order");
  //     await _orders.doc(order.id).delete();
  //     consoleLog("order is is ${order.id}");
  //     return true;
  //   } on FirebaseException catch (e) {
  //     throw e.message!;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  Future<List<model.Order>> getUserOrders(String uid, bool isCompleted) async {
    final Stream<List<model.Order>> ordersStream = _orders
        .where('uid', isEqualTo: uid)
        .where('isCompleted', isEqualTo: isCompleted)
        .snapshots()
        .map((event) {
      List<model.Order> orders = [];
      for (var doc in event.docs) {
        orders.add(
          model.Order.fromMap(doc.data() as Map<String, dynamic>),
        );
      }
      return orders;
    });

    List<model.Order> orders = await ordersStream.first;
    return orders;
  }

  void updateIsCompleted(
      model.Order order, String uid, bool isCompleted) async {
    await _orders.doc(order.id).update({
      "isCompleted": isCompleted,
    });
  }

  CollectionReference get _orders =>
      _firestore.collection(FirebaseConstants.ordersCollection);
}
