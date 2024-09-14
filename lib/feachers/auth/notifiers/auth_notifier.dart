import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manage_orders/feachers/auth/repository/auth_repository.dart';
import 'package:manage_orders/models/user_model.dart';

class AuthNotifier extends AsyncNotifier<UserModel?> {
  late final AuthRepository _authRepository;

  @override
  Future<UserModel?> build() async {
    _authRepository = ref.watch(authRepositoryProvider);
    final authStream = _authRepository.authStateChange;
    final User? user = await authStream.first;

    if (user == null) {
      return null;
    }

    return UserModel(name: user.displayName ?? "No Name", uid: user.uid);
  }

  void signInWithGoogle(bool isFromLogin) async {
    final userModel = await _authRepository.signInWithGoogle(isFromLogin);
    state = AsyncValue.data(userModel);
  }

  void logOut() async {
    _authRepository.logOut();
  }
}

final authProvider =
    AsyncNotifierProvider<AuthNotifier, UserModel?>(AuthNotifier.new);
