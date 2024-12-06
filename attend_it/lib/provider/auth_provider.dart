import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

class AuthState {
  final bool isAuthenticated;
  final String? token;

  AuthState({this.isAuthenticated = false, this.token});
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());

  Future<void> login(String username, String password) async {
    // Implementasi login dengan API
  }

  Future<void> logout() async {
    state = AuthState(isAuthenticated: false, token: null);
  }
}
