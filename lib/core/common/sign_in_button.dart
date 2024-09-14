import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manage_orders/feachers/auth/notifiers/auth_notifier.dart';

class SignInButton extends ConsumerWidget {
  final bool isFromLogin;

  const SignInButton({super.key, this.isFromLogin = true});

  void signINWithGoogle(BuildContext context, WidgetRef ref) {
    ref.read(authProvider.notifier).signInWithGoogle(isFromLogin);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: ElevatedButton(
        onPressed: () => signINWithGoogle(context, ref),
        child: const Text("Continue with Google"),
      ),
    );
  }
}
