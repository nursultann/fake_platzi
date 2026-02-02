import 'package:flutter/material.dart';

import 'screens/product_list_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/login.dart';
import 'screens/register.dart';
import 'screens/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
        '/profile': (context) => const Profile(),
        '/': (context) => const ProductListScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/detail') {
          final productId = settings.arguments as int;

          return MaterialPageRoute(
            builder: (_) => ProductDetailScreen(
              productId: productId,
            ),
          );
        }
        return null;
      },
    );
  }
}
