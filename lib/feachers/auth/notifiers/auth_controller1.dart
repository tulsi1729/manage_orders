// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:manage_orders/core/provider/util.dart';
// import 'package:manage_orders/feathers/auth/repository/auth_repository.dart';
// import 'package:manage_orders/models/user_model.dart';

// // final userProvider = StateProvider<UserModel?>((ref) => null);

// // final authControllerProvider = StateNotifierProvider<AuthController, bool>(
// //   (ref) => AuthController(
// //       authRepository: ref.watch(authRepositoryProvider), ref: ref),
// // );

// // final authStateChangeProvider = StreamProvider((ref) {
// //   final authController = ref.watch(authControllerProvider.notifier);
// //   return authController.authStateChange;
// // });

// class AuthController extends StateNotifier<bool> {
//   final AuthRepository _authRepository;
//   final Ref _ref;

//   AuthController({required AuthRepository authRepository, required Ref ref})
//       : _authRepository = authRepository,
//         _ref = ref,
//         super(false);

//   Stream<User?> get authStateChange => _authRepository.authStateChange;

//   void signInWithGoogle(BuildContext context, bool isFromLogin) async {
//     state = true;
//     final user = await _authRepository.signInWithGoogle(isFromLogin);
//     state = false;
//     user.fold(
//         (l) => showSnackBar(context, l.message),
//         (userModel) =>
//             _ref.read(userProvider.notifier).update((state) => userModel));
//   }

//   void logOut() async {
//     _authRepository.logOut();
//   }
// }
