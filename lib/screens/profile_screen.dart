import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class ProfileScreen extends StatelessWidget {
  final List<CartItem> cart;

  const ProfileScreen({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: const Text(
          'Tài khoản',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 22,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(color: Colors.grey[100], height: 1),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ── Avatar & name ────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Column(
                children: [
                  Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: const Icon(
                      Icons.person_outline_rounded,
                      size: 44,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Binh Nguyen',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'binhnguyen@gmail.com',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Stats row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _StatBox(label: 'Đơn hàng', value: '3'),
                      Container(
                          width: 1,
                          height: 30,
                          color: Colors.grey[200],
                          margin:
                              const EdgeInsets.symmetric(horizontal: 20)),
                      _StatBox(
                          label: 'Giỏ hàng',
                          value: '${cart.length}'),
                      Container(
                          width: 1,
                          height: 30,
                          color: Colors.grey[200],
                          margin:
                              const EdgeInsets.symmetric(horizontal: 20)),
                      _StatBox(label: 'Yêu thích', value: '5'),
                    ],
                  ),
                ],
              ),
            ),

            Divider(color: Colors.grey[100], thickness: 6),

            // ── Menu items ───────────────────────────────────────────
            const SizedBox(height: 8),
            _SectionTitle('Tài khoản'),
            _MenuItem(
              icon: Icons.person_outline,
              label: 'Thông tin cá nhân',
              onTap: () {},
            ),
            _MenuItem(
              icon: Icons.location_on_outlined,
              label: 'Địa chỉ giao hàng',
              onTap: () {},
            ),
            _MenuItem(
              icon: Icons.credit_card_outlined,
              label: 'Phương thức thanh toán',
              onTap: () {},
            ),

            const SizedBox(height: 8),
            Divider(color: Colors.grey[100], thickness: 6),

            const SizedBox(height: 8),
            _SectionTitle('Đơn hàng'),
            _MenuItem(
              icon: Icons.shopping_bag_outlined,
              label: 'Đơn hàng của tôi',
              onTap: () {},
              badge: '3',
            ),
            _MenuItem(
              icon: Icons.favorite_outline,
              label: 'Sản phẩm yêu thích',
              onTap: () {},
            ),
            _MenuItem(
              icon: Icons.history_rounded,
              label: 'Lịch sử xem',
              onTap: () {},
            ),

            const SizedBox(height: 8),
            Divider(color: Colors.grey[100], thickness: 6),

            const SizedBox(height: 8),
            _SectionTitle('Cài đặt'),
            _MenuItem(
              icon: Icons.notifications_none_rounded,
              label: 'Thông báo',
              onTap: () {},
            ),
            _MenuItem(
              icon: Icons.lock_outline,
              label: 'Đổi mật khẩu',
              onTap: () {},
            ),
            _MenuItem(
              icon: Icons.help_outline_rounded,
              label: 'Trợ giúp & Hỗ trợ',
              onTap: () {},
            ),

            const SizedBox(height: 16),

            // ── Logout ───────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/login'),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black, width: 1.5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const Icon(Icons.logout_rounded,
                      color: Colors.black, size: 18),
                  label: const Text(
                    'Đăng xuất',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  const _StatBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(fontSize: 11, color: Colors.grey[400]),
          ),
        ],
      );
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Colors.grey[400],
              letterSpacing: 1.5,
            ),
          ),
        ),
      );
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final String? badge;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.badge,
  });

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            children: [
              Icon(icon, size: 20, color: Colors.black),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              if (badge != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    badge!,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              const SizedBox(width: 4),
              Icon(Icons.chevron_right, size: 18, color: Colors.grey[300]),
            ],
          ),
        ),
      );
}
