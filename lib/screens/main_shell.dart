import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import 'home_screen.dart';
import 'category_screen.dart';
import 'profile_screen.dart';

class MainShell extends StatefulWidget {
  final List<CartItem> cart;

  const MainShell({super.key, required this.cart});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final List<_NavItem> _navItems = const [
    _NavItem(label: 'Trang chủ', icon: Icons.home_outlined,      activeIcon: Icons.home_rounded),
    _NavItem(label: 'Danh mục',  icon: Icons.grid_view_outlined,  activeIcon: Icons.grid_view_rounded),
    _NavItem(label: 'Tài khoản', icon: Icons.person_outline_rounded, activeIcon: Icons.person_rounded),
  ];

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(cart: widget.cart),
      CategoryScreen(cart: widget.cart),
      ProfileScreen(cart: widget.cart),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _AppDrawer(cart: widget.cart, onNavTap: (i) {
        setState(() => _currentIndex = i);
        Navigator.pop(context);
      }),

      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey[100]!)),
        ),
        child: SafeArea(
          child: SizedBox(
            height: 64,
            child: Row(
              children: List.generate(_navItems.length, (i) {
                final item = _navItems[i];
                final selected = i == _currentIndex;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _currentIndex = i),
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: selected ? 24 : 0,
                          height: 3,
                          margin: const EdgeInsets.only(bottom: 4),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        Icon(
                          selected ? item.activeIcon : item.icon,
                          color: selected ? Colors.black : Colors.grey[400],
                          size: 24,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.label,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                            color: selected ? Colors.black : Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final IconData icon;
  final IconData activeIcon;
  const _NavItem({required this.label, required this.icon, required this.activeIcon});
}

class _AppDrawer extends StatelessWidget {
  final List<CartItem> cart;
  final void Function(int) onNavTap;

  const _AppDrawer({required this.cart, required this.onNavTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 28),
              color: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
                    ),
                    child: const Icon(Icons.person_outline_rounded, color: Colors.white, size: 28),
                  ),
                  const SizedBox(height: 14),
                  const Text('Binh Nguyen',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 2),
                  Text('binhnguyen@gmail.com',
                      style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12)),
                  const SizedBox(height: 16),
                  const Text('SOLE.',
                      style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800, letterSpacing: 4)),
                ],
              ),
            ),

            const SizedBox(height: 8),
            _DrawerItem(icon: Icons.home_outlined,       label: 'Trang chủ',  onTap: () => onNavTap(0)),
            _DrawerItem(icon: Icons.grid_view_outlined,  label: 'Danh mục',   onTap: () => onNavTap(1)),
            _DrawerItem(icon: Icons.person_outline_rounded, label: 'Tài khoản', onTap: () => onNavTap(2)),

            Divider(color: Colors.grey[100], height: 24),

            _DrawerItem(
              icon: Icons.shopping_bag_outlined,
              label: 'Giỏ hàng',
              badge: cart.isNotEmpty ? '${cart.length}' : null,
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/cart', arguments: cart);
              },
            ),
            _DrawerItem(icon: Icons.favorite_outline,     label: 'Yêu thích',  onTap: () {}),
            _DrawerItem(icon: Icons.local_offer_outlined, label: 'Khuyến mãi', onTap: () {}),

            const Spacer(),
            Divider(color: Colors.grey[100]),
            _DrawerItem(icon: Icons.help_outline_rounded, label: 'Trợ giúp', onTap: () {}),
            _DrawerItem(
              icon: Icons.logout_rounded,
              label: 'Đăng xuất',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final String? badge;

  const _DrawerItem({required this.icon, required this.label, required this.onTap, this.badge});

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.black),
          const SizedBox(width: 16),
          Expanded(
            child: Text(label,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black)),
          ),
          if (badge != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
              child: Text(badge!,
                  style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
            ),
        ],
      ),
    ),
  );
}