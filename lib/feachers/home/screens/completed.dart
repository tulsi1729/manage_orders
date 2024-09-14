import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manage_orders/core/common/extensions/async_value.dart';
import 'package:manage_orders/feachers/orders/notifier/orders_notifier.dart';
import 'package:manage_orders/models/order_model.dart';

class Completed extends ConsumerWidget {
  const Completed({super.key});

  void updateIsCompleted(WidgetRef ref, Order order, bool isCompleted) async {
    ref
        .read(completedOrdersProvider.notifier)
        .updateIsCompleted(order, isCompleted);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double totalSum = 0;

    return ref.watch(completedOrdersProvider).whenWidget(
      (orders) {
        return Scaffold(
            body: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (BuildContext context, int index) {
                final order = orders[index];
                for (int i = 0; i < orders.length; i++) {
                  totalSum += order.decidedAmount;
                }
                return Card(
                  child: ListTile(
                    title: Text(order.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(order.address),
                        Row(
                          children: [
                            Text("Price : ${order.decidedAmount} ₹"),
                            const Spacer(),
                            Text(order.time.toString()),
                          ],
                        )
                      ],
                    ),
                    trailing: Wrap(
                      children: [
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.edit)),
                        order.isCompleted
                            ? IconButton(
                                icon: const Icon(Icons.pending),
                                onPressed: () {
                                  showDialog<bool>(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Are you sure?'),
                                      content:
                                          const Text('This Order is completed'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, false),
                                          child: const Text('Completed'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            updateIsCompleted(ref, order, true);
                                            Navigator.pop(context, false);
                                          },
                                          child: const Text('UnCompleted'),
                                        ),
                                      ],
                                    ),
                                  );
                                })
                            : IconButton(
                                icon: const Icon(Icons.done),
                                onPressed: () {
                                  updateIsCompleted(ref, order, true);
                                },
                              ),
                      ],
                    ),
                  ),
                );
              },
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Price :  $totalSum",
                style: const TextStyle(fontSize: 25),
              ),
            ));
      },
    );
  }
}
