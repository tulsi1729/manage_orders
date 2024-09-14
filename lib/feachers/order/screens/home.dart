import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manage_orders/feachers/drawer/profile_drawer.dart';
import 'package:manage_orders/feachers/home/screens/completed.dart';
import 'package:manage_orders/feachers/home/screens/upcoming.dart';
import 'package:manage_orders/feachers/order/screens/create_new_order_screen.dart';
import 'package:manage_orders/feachers/order/screens/setting.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  int selectedTabIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const UpComing(),
    const Completed(),
    const Setting(),
    const ProfileDrawer(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          const Setting();
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            selectedTabIndex = index;
          });
        },
        indicatorColor: Color.fromARGB(255, 199, 159, 197),
        selectedIndex: selectedTabIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'UpComing',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.list)),
            label: 'Completed',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outlined),
            label: 'Profile',
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        const UpComing(),

        /// Notifications page
        const Completed(),

        /// Messages page
        const Setting(),

        //profile page
        const ProfileDrawer(),
      ][selectedTabIndex],
    );
  }
}
