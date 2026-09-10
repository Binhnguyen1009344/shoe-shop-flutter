import 'package:flutter/material.dart';
import 'models/cart_item.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/cart_screen.dart';

void main() {
  runApp(const SoleApp());
}

class SoleApp extends StatefulWidget {
  const SoleApp({super.key});

  @override
  State<SoleApp> createState() => _SoleAppState();
}

class _SoleAppState extends State<SoleApp> {
  // Cart được quản lý ở đây và truyền xuống toàn bộ app
  final List<CartItem> _cart = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SOLE. Sneaker Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          brightness: Brightness.light,
        ),
        fontFamily: 'sans-serif',
        useMaterial3: true,
      ),

      // ── Named routes ─────────────────────────────────────────────────────
      initialRoute: '/',
      routes: {
        '/': (_) => const SplashScreen(),
        '/login': (_) => const LoginScreen(),
        '/home': (_) => HomeScreen(cart: _cart),
        '/cart': (_) => CartScreen(cart: _cart),
      },

      // onGenerateRoute xử lý các route nhận arguments
      onGenerateRoute: (settings) {
        // Nếu navigate tới /cart với arguments, vẫn dùng _cart gốc
        if (settings.name == '/cart') {
          return MaterialPageRoute(
            builder: (_) => CartScreen(cart: _cart),
          );
        }
        return null;
      },
    );
  }
}
