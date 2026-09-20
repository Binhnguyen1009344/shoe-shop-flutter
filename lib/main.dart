import 'package:flutter/material.dart';
import 'models/cart_item.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/main_shell.dart';
import 'screens/cart_screen.dart';

void main() {
  runApp(const ShoeShopApp());
}

class ShoeShopApp extends StatefulWidget {
  const ShoeShopApp({super.key});

  @override
  State<ShoeShopApp> createState() => _ShoeShopAppState();
}

class _ShoeShopAppState extends State<ShoeShopApp> {
  final List<CartItem> _cart = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SOLE. Shoe Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          brightness: Brightness.light,
        ),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),

      // ── Named Routes ──────────────────────────────────────────────────
      initialRoute: '/',
      routes: {
        '/':      (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/home':  (context) => MainShell(cart: _cart),
        '/cart':  (context) {
          final cart = ModalRoute.of(context)!.settings.arguments
          as List<CartItem>? ?? _cart;
          return CartScreen(cart: cart);
        },
      },
    );
  }
}