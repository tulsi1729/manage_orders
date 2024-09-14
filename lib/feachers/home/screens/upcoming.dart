import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manage_orders/core/common/extensions/async_value.dart';
import 'package:manage_orders/feachers/order/screens/create_new_order_screen.dart';
import 'package:manage_orders/feachers/orders/notifier/orders_notifier.dart';
import 'package:manage_orders/models/order_model.dart';

class UpComing extends ConsumerWidget {
  final bool isEditMode;
  final Order? preFilledOrder;
  const UpComing({super.key, this.isEditMode = false, this.preFilledOrder});

  void updateIsCompleted(WidgetRef ref, Order order, bool isCompleted) async {
    ref
        .read(upcomingOrdersProvider.notifier)
        .updateIsCompleted(order, isCompleted);
  }

  void navigateToCreateOrder(BuildContext context, Order order) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => CreateNewOrder(
              isEditMode: true,
              preFilledOrder: order,
            )));
    // Routemaster.of(context).push('/create-new-order');
  }

  // void deletedOrder(BuildContext context, WidgetRef ref, Order order) {
  //   ref.read(orderProvider.notifier).deletedOrder(order, ref).then((isDeleted) {
  //     if (isDeleted) {
  //       showSnackBar(context, 'Deleted order');
  //     } else {
  //       showSnackBar(context, 'Not Deleted order');
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          elevation: 4,
          title: const Text("Upcoming Orders List"),
        ),
        body: ref.watch(upcomingOrdersProvider).whenWidget((orders) {
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (BuildContext context, int index) {
              final order = orders[index];
              return Card(
                child: ListTile(
                    title: Text(order.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(order.address),
                        Text("Price : ${order.decidedAmount.toString()} ₹"),
                        Text("Date : ${order.time}"),
                      ],
                    ),
                    trailing: Wrap(
                      children: [
                        IconButton(
                          onPressed: () {
                            navigateToCreateOrder(context, order);
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.delete),
                        ),
                        Container(
                          child: order.isCompleted
                              ? IconButton(
                                  icon: const Icon(Icons.pending),
                                  onPressed: () =>
                                      updateIsCompleted(ref, order, false),
                                )
                              : IconButton(
                                  icon: const Icon(Icons.done),
                                  onPressed: () {
                                    showDialog<bool>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text(order.name),
                                        content: TextField(
                                          decoration: InputDecoration(
                                              hintText:
                                                  "${order.decidedAmount.toString()} ₹"),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, false),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              updateIsCompleted(
                                                  ref, order, false);
                                              Navigator.pop(context, false);
                                            },
                                            child: const Text('Ok'),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                        ),
                      ],
                    )),
              );
            },
          );
        }));
  }
}
