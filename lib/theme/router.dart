import 'package:flutter/material.dart';
import 'package:manage_orders/feachers/auth/screens/login_screen.dart';
import 'package:manage_orders/feachers/home/screens/completed.dart';
import 'package:manage_orders/feachers/order/screens/home.dart';
import 'package:manage_orders/feachers/order/screens/home_screen.dart';
import 'package:manage_orders/feachers/order/screens/create_new_order_screen.dart';
import 'package:manage_orders/feachers/home/screens/upcoming.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginScreen()),
});

final loggedInRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: Home()),
  '/create-new-order': (_) => const MaterialPage(
        child: CreateNewOrder(),
      ),
  '/upcoming-order': (_) => const MaterialPage(
        child: UpComing(),
      ),
  '/completed-order': (_) => const MaterialPage(
        child: Completed(),
      ),
});
