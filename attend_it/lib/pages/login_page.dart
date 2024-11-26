import 'package:attend_it/bloc/auth/auth_bloc.dart';
import 'package:attend_it/pages/home_page.dart';
import 'package:attend_it/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthRepository authRepository = AuthRepository(); 
  late AuthBloc authBloc;

  @override 
  void initState() { 
    super.initState(); 
    authBloc = AuthBloc(authRepository: authRepository); 
  }

  @override 
  void dispose() { 
    authBloc.close(); 
    super.dispose(); 
  }

  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      backgroundColor: Colors.white, 
      body: BlocProvider( 
        create: (_) => authBloc, 
        child: LoginForm(), 
      ), 
    ); 
  }
}

class LoginForm extends StatefulWidget { 
  @override _LoginFormState createState() => _LoginFormState(); 
}
  
class _LoginFormState extends State<LoginForm> { 
  final TextEditingController _usernameController = TextEditingController(); 
  final TextEditingController _passwordController = TextEditingController(); 
  bool _isObscured = true; 
  
  void _togglePasswordView() { 
    setState(() { 
      _isObscured = !_isObscured; 
      }); 
    }

  void _login() { 
    final username = _usernameController.text; 
    final password = _passwordController.text; 
    if (username.isNotEmpty && password.isNotEmpty) { 
      context.read<AuthBloc>().add(AuthLogin(username: username, password: password)); 
    } 
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'assets/images/logo_jti.jpg',
                height: 200,
              ),
              const SizedBox(height: 20),

              // Title
              const Text(
                'Presensi Online',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0047AB),
                ),
              ),
              const Text(
                'JTI Polinema',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0047AB),
                ),
              ),
              const SizedBox(height: 30),

              // Username Input
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: 'Username',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  filled: true,
                  fillColor: const Color(0xFFF3F4F6),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Password Input with Toggle Visibility
              TextFormField(
                controller: _passwordController,
                obscureText: _isObscured,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  filled: true,
                  fillColor: const Color(0xFFF3F4F6),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscured ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: _togglePasswordView,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Remember Me Checkbox
              Row(
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (bool? value) {
                      // Handle checkbox change
                    },
                  ),
                  const Text(
                    'Ingat Password',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Login Button and Fingerprint Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Login Button
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF2B400),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 100, vertical: 25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 5),

                  // Fingerprint Icon
                  CircleAvatar(
                    backgroundColor: const Color(0xFFF2B400).withOpacity(0.2),
                    radius: 25,
                    child: const Icon(
                      Icons.fingerprint,
                      size: 40,
                      color: Color(0xFFF2B400),
                    ),
                  ),
                ],
              ),

              // BlocBuilder to react to state changes 
              BlocBuilder<AuthBloc, AuthState>( 
                builder: (context, state) { 
                  if (state is AuthLoading) { 
                    return CircularProgressIndicator(); 
                  } else if (state is AuthAuthenticated) { 
                    WidgetsBinding.instance.addPostFrameCallback((_) { 
                      Navigator.pushReplacement( 
                        context, 
                        MaterialPageRoute( 
                          builder: (context) => const HomePage(), 
                        ), 
                      ); 
                    }); 
                  } else if (state is AuthError) { 
                    return Text( 
                      state.message, 
                      style: TextStyle(color: Colors.red), 
                    ); 
                  } return Container(); 
                }, 
              ),
            ],
          ),
        ),
      ),
    );
  }
}
