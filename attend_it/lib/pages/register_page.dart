import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:attend_it/provider/auth_provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nimController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailController = TextEditingController();
  final _namaMahasiswaController = TextEditingController();
  final _prodiController = TextEditingController();
  final _idKelasController = TextEditingController();
  bool _isObscured = true;
  bool _isConfirmObscured = true;
  bool _isLoading = false;
  String? _selectedProdi;
  String? _selectedKelas;
  final List<String> _prodiList = [
    'Teknik Informatika',
    'Sistem Informasi Bisnis'
  ];
  final Map<String, List<Map<String, dynamic>>> _kelasMap = {
    'Teknik Informatika': [
      {'id': '1', 'name': 'TI-3A'},
      {'id': '2', 'name': 'TI-3B'},
      {'id': '3', 'name': 'TI-3C'},
      {'id': '4', 'name': 'TI-3D'},
      {'id': '5', 'name': 'TI-3E'},
      {'id': '6', 'name': 'TI-3F'},
      {'id': '7', 'name': 'TI-3G'},
      {'id': '8', 'name': 'TI-3H'},
      {'id': '9', 'name': 'TI-3I'}
    ],
    'Sistem Informasi Bisnis': [
      {'id': '10', 'name': 'SIB-3A'},
      {'id': '11', 'name': 'SIB-3B'},
      {'id': '12', 'name': 'SIB-3C'},
      {'id': '13', 'name': 'SIB-3D'},
      {'id': '14', 'name': 'SIB-3E'}
    ],
  };
  File? _selectedImage;

  void _togglePasswordView() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  void _toggleConfirmPasswordView() {
    setState(() {
      _isConfirmObscured = !_isConfirmObscured;
    });
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final notifier = ref.read(authProvider.notifier);
        await notifier.register(
          email: _emailController.text,
          username: _usernameController.text,
          password: _passwordController.text,
          nim: _nimController.text,
          namaMahasiswa: _namaMahasiswaController.text,
          prodi: _prodiController.text,
          idKelas: _idKelasController.text,
          foto: _selectedImage,
        );
        // Navigate to login page after successful registration
        if (mounted) {
          context.go('/login');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Registration successful! Please login.')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo_jti.jpg',
                    height: 150,
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(60),
                        border: Border.all(color: const Color(0xFF0047AB), width: 2),
                      ),
                      child: _selectedImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Image.file(
                                _selectedImage!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Icon(
                              Icons.add_a_photo,
                              size: 40,
                              color: Color(0xFF0047AB),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Register Account',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0047AB),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // NIM Input
                  TextFormField(
                    controller: _nimController,
                    decoration: InputDecoration(
                      hintText: 'NIM',
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      filled: true,
                      fillColor: const Color(0xFFF3F4F6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your NIM';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Username Input
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      filled: true,
                      fillColor: const Color(0xFFF3F4F6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Password Input
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _isObscured,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      filled: true,
                      fillColor: const Color(0xFFF3F4F6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(_isObscured
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: _togglePasswordView,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Confirm Password Input
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _isConfirmObscured,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      filled: true,
                      fillColor: const Color(0xFFF3F4F6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(_isConfirmObscured
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: _toggleConfirmPasswordView,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Email Input
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      filled: true,
                      fillColor: const Color(0xFFF3F4F6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Nama Mahasiswa Input
                  TextFormField(
                    controller: _namaMahasiswaController,
                    decoration: InputDecoration(
                      hintText: 'Nama Lengkap',
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      filled: true,
                      fillColor: const Color(0xFFF3F4F6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Program Studi Dropdown
                  DropdownButtonFormField<String>(
                    value: _selectedProdi,
                    decoration: InputDecoration(
                      hintText: 'Program Studi',
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      filled: true,
                      fillColor: const Color(0xFFF3F4F6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: _prodiList.map((String prodi) {
                      return DropdownMenuItem(
                        value: prodi,
                        child: Text(prodi),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedProdi = newValue;
                        _selectedKelas = null; // Reset kelas when prodi changes
                        _prodiController.text = newValue ?? '';
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your program of study';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Kelas Dropdown
                  DropdownButtonFormField<String>(
                    value: _selectedKelas,
                    decoration: InputDecoration(
                      hintText: 'Kelas',
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      filled: true,
                      fillColor: const Color(0xFFF3F4F6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: _selectedProdi != null
                        ? _kelasMap[_selectedProdi]!.map((kelas) {
                            return DropdownMenuItem<String>(
                              value: kelas['id'] as String,
                              child: Text(kelas['name'] as String),
                            );
                          }).toList()
                        : [],
                    onChanged: _selectedProdi != null
                        ? (String? newValue) {
                            setState(() {
                              _selectedKelas = newValue;
                              _idKelasController.text = newValue ?? '';
                            });
                          }
                        : null,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your class';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),

                  // Register Button
                  ElevatedButton(
                    onPressed: _isLoading ? null : _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF2B400),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 100,
                        vertical: 25,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : const Text(
                            'REGISTER',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                  const SizedBox(height: 20),

                  // Login Link
                  TextButton(
                    onPressed: () => context.go('/login'),
                    child: const Text(
                      'Already have an account? Login',
                      style: TextStyle(color: Color(0xFF0047AB)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
