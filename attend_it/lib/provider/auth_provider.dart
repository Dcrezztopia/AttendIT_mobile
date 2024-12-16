import 'dart:io';
import 'dart:convert';
import 'package:attend_it/services/api_config.dart';
import 'package:attend_it/services/secure_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

// import 'package:shared_preferences/shared_preferences.dart';

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

  AuthState(
      {this.isAuthenticated = false,
      this.token,
      this.user,
      this.mahasiswa,
      this.isLoading = false});

  /// Initial state factory
  factory AuthState.initial() =>
      AuthState(isAuthenticated: false, isLoading: false);

  /// Copy method to easily update state.
  AuthState copyWith({
    bool? isAuthenticated,
    String? token,
    Map<String, dynamic>? user,
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
  final SecureStorageService _storageService = SecureStorageService();

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

        // Simpan token menggunakan Secure Storage
        await _storageService.writeToken(token);

        // Update state
        state = AuthState(
          isAuthenticated: true,
          token: token,
          user: user,
          isLoading: true,
        );

        // Fetch user profile
        await getProfile(token);
      } else {
        state = AuthState.initial(); // Reset state if login fails
        throw Exception('Invalid username or password');
      }
    } catch (e) {
      state = AuthState.initial(); // Reset state on error
      // print('Error in login: $e');
      rethrow;
    }
  }

  /// Logout the current user.
  Future<void> logout() async {
    try {
      // Hapus token menggunakan Secure Storage
      await _storageService.deleteToken();

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
      final token = await _storageService.readToken();
      if (token == null || token.isEmpty) {
        print('Token not found');
        state = state.copyWith(isLoading: false);
        return;
      }

      print('Token found: $token');

      // Verify token validity
      final response = await http.get(
        Uri.parse('$baseUrl/profile'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        await getProfile(token);
      } else {
        // Token is invalid, clear it
        await _storageService.deleteToken();
        state = AuthState.initial();
        print('Token is invalid, user needs to log in again');
      }
    } catch (e) {
      state = AuthState.initial();
      // print('Error in tryAutoLogin: $e');
    } finally {
      state = state.copyWith(isLoading: false);
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

        // print('User: $user');
        // print('Mahasiswa: $mahasiswa'); // Debug statement

        state = state.copyWith(
            isAuthenticated: true,
            token: token,
            user: user,
            mahasiswa: mahasiswa,
            isLoading: false);
      } else {
        state = AuthState.initial();
        throw Exception('Failed to load profile');
      }
    } catch (e) {
      state = AuthState.initial();
      // print('Error in getProfile: $e');
      rethrow;
    }
  }

  Future<void> register({
    required String email,
    required String username,
    required String password,
    required String nim,
    required String namaMahasiswa,
    required String prodi,
    required String idKelas,
    File? foto,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      var uri = Uri.parse('$baseUrl/register');
      var request = http.MultipartRequest('POST', uri);

      // Add headers
      request.headers.addAll({
        'Accept': 'application/json',
      });

      // Add text fields
      request.fields.addAll({
        'email': email,
        'username': username,
        'password': password,
        'role': 'mahasiswa',
        'nim': nim,
        'nama_mahasiswa': namaMahasiswa,
        'prodi': prodi,
        'id_kelas': idKelas,
      });

      if (foto != null) {
        final mimeType = lookupMimeType(foto.path);
        request.files.add(await http.MultipartFile.fromPath(
          'foto',
          foto.path,
          contentType: mimeType != null
              ? MediaType.parse(mimeType)
              : MediaType('image', 'jpeg'),
        ));
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        if (responseData['message'] == 'User registered successfully') {
          state = state.copyWith(isLoading: false);
        } else {
          throw Exception('Registration failed: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Registration failed: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }
}
