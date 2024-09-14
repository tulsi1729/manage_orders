import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manage_orders/core/common/extensions/async_value.dart';
import 'package:manage_orders/feachers/auth/notifiers/auth_notifier.dart';
import 'package:manage_orders/firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:manage_orders/theme/router.dart';
import 'package:routemaster/routemaster.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(authProvider).whenWidget(
      (user) {
        bool isAuthanticated = user != null;

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Manage Orders',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerDelegate: RoutemasterDelegate(
            routesBuilder: (context) =>
                isAuthanticated ? loggedInRoute : loggedOutRoute,
          ),
          routeInformationParser: const RoutemasterParser(),
        );
      },
    );
  }
}
