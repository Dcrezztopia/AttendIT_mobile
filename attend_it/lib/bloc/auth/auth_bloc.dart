import 'package:attend_it/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:attend_it/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) { 
    on<AuthRegister>(_onRegister); 
    on<AuthLogin>(_onLogin); 
    on<AuthLogout>(_onLogout);
  }

  void _onRegister(AuthRegister event, Emitter<AuthState> emit) async { 
    emit(AuthLoading()); 
    try { 
      final user = await authRepository.register( 
        event.email, 
        event.username, 
        event.password, 
        event.role, 
        nim: event.nim, 
        namaMahasiswa: event.namaMahasiswa, 
        prodi: event.prodi, 
        idKelas: event.idKelas, 
      ); 
      emit(AuthAuthenticated(user: user)); 
    } catch (e) { 
      emit(AuthError(message: e.toString())); 
    }
  }

  void _onLogin(AuthLogin event, Emitter<AuthState> emit) async { 
    emit(AuthLoading()); 
    try { 
      final user = await authRepository.login(
        event.username, 
        event.password
      ); 
      await authRepository.saveToken(user.token); // Simpan token setelah login berhasil
      emit(AuthAuthenticated(user: user)); 
    } catch (e) { 
      emit(AuthError(message: e.toString())); 
    } 
  }  

  void _onLogout(AuthLogout event, Emitter<AuthState> emit) async { 
    emit(AuthLoading()); 
    try { 
      await authRepository.logout(event.token); 
      emit(AuthUnauthenticated()); 
    } catch (e) { 
      emit(AuthError(message: e.toString())); 
    } 
  }
}
