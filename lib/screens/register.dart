import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;
  String? error;

  Future<void> handleRegister() async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      await AuthService.register(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        avatar: 'https://picsum.photos/800',
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
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 12),
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
              onPressed: loading ? null : handleRegister,
              child: loading
                  ? const CircularProgressIndicator()
                  : const Text('Create account'),
            ),
          ],
        ),
      ),
    );
  }
}
