import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthInitial());

  Future<void> login(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      emit(const AuthError('Please fill in all fields'));
      return;
    }

    emit(const AuthLoading());

    await Future.delayed(const Duration(seconds: 2));

    emit(AuthSuccess(_nameFromUsername(username)));
  }

  Future<void> signUp(String name, String email, String password) async {
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      emit(const AuthError('Please fill in all fields'));
      return;
    }

    emit(const AuthLoading());

    await Future.delayed(const Duration(seconds: 2));

    emit(AuthSuccess(name));
  }

  void logout() {
    emit(const AuthInitial());
  }

  String _nameFromUsername(String username) {
  final cleaned = username.startsWith('@') ? username.substring(1) : username;
  final prefix = cleaned.split('@').first;
  if (prefix.isEmpty) return 'there';
  return prefix[0].toUpperCase() + prefix.substring(1);
}
}
