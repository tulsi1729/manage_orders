import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manage_orders/core/common/extensions/async_value.dart';
import 'package:manage_orders/feachers/auth/notifiers/auth_notifier.dart';

class ProfileDrawer extends ConsumerWidget {
  const ProfileDrawer({super.key});

  void logOut(WidgetRef ref) {
    ref.read(authProvider.notifier).logOut();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(authProvider);

    return userAsync.whenWidget((user) {
      return Drawer(
        child: SafeArea(
            child: Center(
          child: Column(
            children: [
              Text(user!.name),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () => logOut(ref), child: const Text("Log Out"))
            ],
          ),
        )),
      );
    });
  }
}
