import 'dart:convert';
import 'package:attend_it/provider/api_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// Provider for managing authentication state.
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

/// Class representing the authentication state.
class AuthState {
  final bool isAuthenticated;
  final String? token;
  final Map<String, dynamic>? user;
  final Map<String, dynamic>? mahasiswa;
  final bool isLoading;

  AuthState({this.isAuthenticated = false, this.token, this.user, this.mahasiswa, this.isLoading = false});

  /// Initial state factory
  factory AuthState.initial() => AuthState(isAuthenticated: false, isLoading: false);

  /// Copy method to easily update state. 
  AuthState copyWith({ 
    bool? isAuthenticated, 
    String? token, 
    Map<String, 
    dynamic>? user, 
    Map<String, dynamic>? mahasiswa, 
    bool? isLoading, 
  }) { 
    return AuthState( 
      isAuthenticated: isAuthenticated ?? this.isAuthenticated, 
      token: token ?? this.token, 
      user: user ?? this.user, 
      mahasiswa: mahasiswa ?? this.mahasiswa, 
      isLoading: isLoading ?? this.isLoading, 
    ); 
  }
  
}

/// StateNotifier to handle authentication logic.
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState.initial());

  /// Login the user with the provided credentials.
  Future<void> login(String username, String password) async {
    state = state.copyWith(isLoading: true);
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        final user = data['user'];

        // Save token to shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        // Update state
        state = AuthState(isAuthenticated: true, token: token, user: user, isLoading: true);

        // Fetch user profile 
        await getProfile(token);
      } else {
        state = AuthState.initial(); // Reset state if login fails
        throw Exception('Invalid username or password');
      }
    } catch (e) {
      state = AuthState.initial(); // Reset state on error
      print('Error in login: $e');
      rethrow;
    }
  }

  /// Logout the current user.
  Future<void> logout() async {
    try {
      // Remove token from shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');

      // Update state
      state = AuthState.initial();
    } catch (e) {
      // Log or handle the error appropriately
      rethrow;
    }
  }

  // Attempt to log in automatically using stored credentials.
  Future<void> tryAutoLogin() async {
    state = state.copyWith(isLoading: true);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey('token')) {
        print('Token not found');
        state = state.copyWith(isLoading: false); // Pastikan loading berhenti
        return;
      }

      final token = prefs.getString('token');
      print('Token found: $token');
      // state = state.copyWith(isAuthenticated: true, token: token, isLoading: true);

      // Fetch user profile 
      await getProfile(token);
      // state = state.copyWith(isAuthenticated: true, token: token, isLoading: false);
    } catch (e) {
      state = AuthState.initial();
      print('Error in tryAutoLogin: $e');
      state = state.copyWith(isLoading: false); // Reset state loading saat error
      rethrow;
    }
  }

  Future<void> getProfile(String? token) async { 
    try { 
      final response = await http.get( 
        Uri.parse('$baseUrl/profile'), 
        headers: { 
          'Authorization': 'Bearer $token', 
        }, 
      ); 
      if (response.statusCode == 200) { 
        final data = jsonDecode(response.body); 
        final user = data['user']; 
        final mahasiswa = data['mahasiswa']; 

        print('User: $user'); 
        print('Mahasiswa: $mahasiswa'); // Debug statement
        
        state = state.copyWith(isAuthenticated: true, token: token, user: user, mahasiswa: mahasiswa, isLoading: false); 
      } else { 
        state = AuthState.initial();
        throw Exception('Failed to load profile'); 
      } 
    } catch (e) { 
      state = AuthState.initial();
      print('Error in getProfile: $e');
      rethrow; 
    } 
  }
}
