import 'dart:convert';
import 'package:attend_it/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final String baseUrl = "http://127.0.0.1:8000/api";

  // Simpan token setelah login 
  Future<void> saveToken(String token) async { 
    SharedPreferences prefs = await SharedPreferences.getInstance(); 
    await prefs.setString('auth_token', token); 
  } 

  // Dapatkan token untuk digunakan dalam permintaan API 
  Future<String?> getToken() async { 
    SharedPreferences prefs = await SharedPreferences.getInstance(); 
    return prefs.getString('auth_token');
  }

  Future<User> register(String email, String username, String password, String role, {String? nim, String? namaMahasiswa, String? prodi, String? idKelas}) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      body: {
        'email': email,
        'username': username,
        'password': password,
        'role': role,
        if (role == 'mahasiswa') 'nim': nim,
        if (role == 'mahasiswa') 'nama_mahasiswa': namaMahasiswa,
        if (role == 'mahasiswa') 'prodi': prodi,
        if (role == 'mahasiswa') 'id_kelas': idKelas,
      },
    );

    if (response.statusCode == 201) {
      final user = User.fromJson(json.decode(response.body)['user']); 
      await saveToken(user.token); // Simpan token 
      return user;
    } else {
      throw Exception('Failed to register');
    }
  }

  Future<User> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      print(json.decode(response.body)); // cek aja di debug console
      
      final responseBody = json.decode(response.body); 
      final userJson = responseBody['user']; 
      final token = responseBody['token']; 

      if (token == null) { 
        throw Exception('Token is null'); 
      } 
      return User.fromJson({ 
        ...userJson, 'token': token,
      });
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> logout(String token) async {
    final token = await getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');
    } else {
      throw Exception('Failed to logout');
    }
  }
}
