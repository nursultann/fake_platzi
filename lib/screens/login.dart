import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;
  String? error;

  Future<void> handleLogin() async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      await AuthService.login(
        email: emailController.text,
        password: passwordController.text,
      );

      Navigator.pushReplacementNamed(context, '/profile');
    } catch (e) {
      setState(() {
        error = e.toString().replaceAll('Exception: ', '');
      });
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 24),

            if (error != null)
              Text(error!, style: const TextStyle(color: Colors.red)),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: loading ? null : handleLogin,
              child: loading
                  ? const CircularProgressIndicator()
                  : const Text('Login'),
            ),

            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
