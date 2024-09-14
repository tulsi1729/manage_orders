import 'package:flutter/material.dart';
import 'package:manage_orders/core/common/extensions/on_build_context.dart';
import 'package:manage_orders/feachers/drawer/profile_drawer.dart';
import 'package:routemaster/routemaster.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void navigateToCreateOrder(BuildContext context) {
    Routemaster.of(context).push('/create-new-order');
  }

  void navigateToUpComing(BuildContext context) {
    Routemaster.of(context).push('/upcoming-order');
  }

  void navigateToCompleted(BuildContext context) {
    Routemaster.of(context).push('/completed-order');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const ProfileDrawer(),
      appBar: AppBar(
        elevation: 4,
        title: Text(context.l10n.homeTitle),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () => navigateToUpComing(context),
                child: const Text("UpComing")),
            ElevatedButton(
                onPressed: () => navigateToCompleted(context),
                child: const Text("Completed")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => navigateToCreateOrder(context),
      ),
    );
  }
}
