import 'package:flutter/material.dart';
import 'package:manage_orders/core/common/sign_in_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login screen"),
        ),
        body: const Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SignInButton(),
          ],
        ));
  }
}
