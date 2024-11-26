// lib/blocs/auth_event.dart

part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthRegister extends AuthEvent {
  final String email;
  final String username;
  final String password;
  final String role;
  final String? nim;
  final String? namaMahasiswa;
  final String? prodi;
  final String? idKelas;

  AuthRegister({
    required this.email,
    required this.username,
    required this.password,
    required this.role,
    this.nim,
    this.namaMahasiswa,
    this.prodi,
    this.idKelas,
  });
}

class AuthLogin extends AuthEvent {
  final String username;
  final String password;

  AuthLogin({required this.username, required this.password});
}

class AuthLogout extends AuthEvent {
  final String token;

  AuthLogout({required this.token});
}
