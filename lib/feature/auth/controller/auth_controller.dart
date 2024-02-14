import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:strideon/feature/auth/repository/auth_repository.dart';
import 'package:strideon/models/user_model.dart';
import 'package:strideon/utils/snackbar/show_snackbar.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
    (ref) => AuthController(authRepository: ref.read(authRepositoryProvider)));

final userProvider = StateProvider<UserModel?>((ref) => null);

final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

final getUserDataProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;

  AuthController({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(false);

  Stream<User?> get authStateChange => _authRepository.authStateChange;

  Future<void> signWithGoogle(BuildContext context) async {
    try {
      state = true;

      await _authRepository.signInWithGoogle();

      state = false;
    } catch (e) {
      GoRouter.of(context).pop();
      showSnackBar(context, e.toString());
      state = false;
    }
  }

  void signUpWithEmail(String emailAddress, String password) async {
    state = true;
    await _authRepository.createUserWithEmail(emailAddress, password);
    state = false;
  }

  void signInWithEmail(String emailAddress, String password) async {
    state = true;
    await _authRepository.signInWithEmail(emailAddress, password);
    state = false;
  }

  void signOut(BuildContext context) {
    try {
      _authRepository.logOut();
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void forgetPassword() {
    _authRepository.passwordReset();
  }

  void deleteAccount(BuildContext context) {
    try {
      state = true;
      _authRepository.deleteUserAccount();
      state = false;
    } catch (e) {
      state = false;
      showSnackBar(context, e.toString());
    }
  }

  Stream<UserModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }
}
