import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manage_orders/core/common/extensions/on_build_context.dart';
import 'package:manage_orders/core/provider/util.dart';
import 'package:manage_orders/feachers/auth/notifiers/auth_notifier.dart';
import 'package:manage_orders/feachers/home/screens/upcoming.dart';
import 'package:manage_orders/feachers/order/notifier/order_notifier.dart';
import 'package:manage_orders/models/order_model.dart' as model;
import 'package:manage_orders/models/user_model.dart';
import 'package:uuid/uuid.dart';

class CreateNewOrder extends ConsumerStatefulWidget {
  final bool isEditMode;
  final model.Order? preFilledOrder;
  const CreateNewOrder(
      {super.key, this.isEditMode = false, this.preFilledOrder});

  ConsumerState<ConsumerStatefulWidget> createState() => _CreateNewOrderState();
}

class _CreateNewOrderState extends ConsumerState<CreateNewOrder> {
  final orderNameController = TextEditingController();
  final orderAddressController = TextEditingController();
  final orderDateController = TextEditingController();
  final orderReceivedAmountController = TextEditingController();
  final orderDecidedAmountController = TextEditingController();

  void  navigateToUpdatingOrder(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UpComing()),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.isEditMode) {
      orderNameController.text = widget.preFilledOrder!.name;
      orderAddressController.text = widget.preFilledOrder!.address;
      orderDecidedAmountController.text =
          widget.preFilledOrder!.decidedAmount.toString();
      orderDateController.text = widget.preFilledOrder!.time.toString();
    }
  }

  @override
  void dispose() {
    super.dispose();
    orderNameController.dispose();
    orderAddressController.dispose();
    orderReceivedAmountController.dispose();
    orderDecidedAmountController.dispose();
    orderDateController.dispose();
  }

  Future<void> createOrder() async {
    UserModel userModel = (await ref.read(authProvider.future))!;

    model.Order newOrder = model.Order(
      id: const Uuid().v4(),
      name: orderNameController.text,
      address: orderAddressController.text,
      time: DateTime.now(),
      isCompleted: false,
      uid: userModel.uid,
      decidedAmount: double.tryParse(orderDecidedAmountController.text) ?? 0,
      receivedAmount: 0,
    );
    final bool isOrderCompleted =
        await ref.read(orderProvider.notifier).createOrder(newOrder);

    if (isOrderCompleted) {
      // ignore: use_build_context_synchronously
      // showSnackBar(context, "Order created Successfully");
    } else {
      // ignore: use_build_context_synchronously
      // showSnackBar(context, "Order not created Successfully");
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _selectDate() async {
      DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );

      if (_picked != null) {
        setState(() {
          orderDateController.text = _picked.toString().split(" ")[0];
        });
      }
    }

    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 4,
          title: Text(widget.isEditMode
              ? context.l10n.editOrderTitle
              : context.l10n.createNewOrderTitle),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: orderNameController,
                  decoration: InputDecoration(
                      hintText: context.l10n.orderNameRequiredMessage),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: orderAddressController,
                  decoration: InputDecoration(
                      hintText: context.l10n.orderAddressRequiredMessage),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter address';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: orderDecidedAmountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: context.l10n.orderDecidedAmountRequiredMessage),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter price';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: orderDateController,
                  decoration: InputDecoration(
                      labelText: 'DATE',
                      filled: true,
                      prefixIcon: const Icon(Icons.calendar_today),
                      hintText: context.l10n.orderTimeRequiredMessage,
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter date';
                    }
                    return null;
                  },
                  readOnly: true,
                  onTap: () {
                    _selectDate();
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (widget.isEditMode) {
                        final model.Order editedOrder = model.Order(
                          id: widget.preFilledOrder!.id,
                          name: orderNameController.text,
                          address: orderAddressController.text,
                          decidedAmount: double.tryParse(
                                  orderDecidedAmountController.text) ??
                              0,
                          receivedAmount: 0,
                          time: DateTime.now(),
                          uid: widget.preFilledOrder!.uid,
                          isCompleted: false,
                        );
                        ref
                            .read(orderProvider.notifier)
                            .editedOrder(editedOrder);
                      } else {
                        navigateToUpdatingOrder(context);
                      }
                    }
                  },
                  child: Text(
                    context.l10n.orderSubmitMessage,
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
