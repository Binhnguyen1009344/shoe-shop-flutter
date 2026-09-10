import 'package:flutter/material.dart';
import '../models/shoe.dart';
import '../models/cart_item.dart';

class DetailScreen extends StatefulWidget {
  final Shoe shoe;
  final List<CartItem> cart;

  const DetailScreen({super.key, required this.shoe, required this.cart});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String? _selectedSize;
  bool _addedToCart = false;

  String _fmt(double p) {
    final s = p.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]}.',
        );
    return '${s}đ';
  }

  void _addToCart() {
    if (_selectedSize == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Vui lòng chọn size trước.'),
          backgroundColor: Colors.black,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ),
      );
      return;
    }

    // Check if same shoe + size already in cart
    final existing = widget.cart.where((item) =>
        item.shoe.id == widget.shoe.id &&
        item.selectedSize == _selectedSize);

    if (existing.isNotEmpty) {
      existing.first.quantity++;
    } else {
      widget.cart.add(
        CartItem(shoe: widget.shoe, selectedSize: _selectedSize!),
      );
    }

    setState(() => _addedToCart = true);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đã thêm ${widget.shoe.name} vào giỏ hàng!'),
        backgroundColor: Colors.black,
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        action: SnackBarAction(
          label: 'Xem giỏ',
          textColor: Colors.white,
          onPressed: () =>
              Navigator.pushNamed(context, '/cart', arguments: widget.cart),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final shoe = widget.shoe;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // ── Image hero ─────────────────────────────────────────────────
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 340,
                  pinned: true,
                  backgroundColor: Colors.white,
                  surfaceTintColor: Colors.transparent,
                  leading: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back, color: Colors.black),
                    ),
                  ),
                  actions: [
                    // Cart shortcut
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        '/cart',
                        arguments: widget.cart,
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          children: [
                            const Icon(Icons.shopping_bag_outlined,
                                color: Colors.black, size: 22),
                            if (widget.cart.isNotEmpty)
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  width: 14,
                                  height: 14,
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${widget.cart.fold(0, (sum, item) => sum + item.quantity)}',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 8),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      color: Colors.grey[50],
                      child: Image.network(
                        shoe.imageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (_, child, progress) =>
                            progress == null
                                ? child
                                : Container(
                                    color: Colors.grey[100],
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                          strokeWidth: 1.5,
                                          color: Colors.black38),
                                    ),
                                  ),
                        errorBuilder: (_, __, ___) => Container(
                          color: Colors.grey[100],
                          child: const Icon(Icons.image_not_supported,
                              size: 48, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),

                // ── Product info ──────────────────────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Brand + category
                        Row(
                          children: [
                            Text(
                              shoe.brand.toUpperCase(),
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[400],
                                letterSpacing: 2,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                shoe.category,
                                style: const TextStyle(
                                    fontSize: 11, color: Colors.black54),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 6),

                        // Name
                        Text(
                          shoe.name,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                            height: 1.2,
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Price
                        Text(
                          _fmt(shoe.price),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),

                        const SizedBox(height: 20),
                        Divider(color: Colors.grey[100]),
                        const SizedBox(height: 20),

                        // Description
                        const Text(
                          'Mô tả sản phẩm',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            letterSpacing: 0.3,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          shoe.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            height: 1.6,
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Size selection
                        const Text(
                          'Chọn size',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            letterSpacing: 0.3,
                          ),
                        ),
                        const SizedBox(height: 12),

                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: shoe.sizes.map((size) {
                            final selected = _selectedSize == size;
                            return GestureDetector(
                              onTap: () =>
                                  setState(() => _selectedSize = size),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 150),
                                width: 52,
                                height: 52,
                                decoration: BoxDecoration(
                                  color: selected
                                      ? Colors.black
                                      : Colors.grey[50],
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: selected
                                        ? Colors.black
                                        : Colors.grey[200]!,
                                    width: 1.5,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    size,
                                    style: TextStyle(
                                      color: selected
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Bottom action bar ──────────────────────────────────────────
          Container(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey[100]!)),
            ),
            child: Row(
              children: [
                // Go to cart
                GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    '/cart',
                    arguments: widget.cart,
                  ),
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Stack(
                      children: [
                        const Center(
                          child: Icon(Icons.shopping_bag_outlined,
                              color: Colors.black),
                        ),
                        if (widget.cart.isNotEmpty)
                          Positioned(
                            right: 8,
                            top: 8,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '${widget.cart.fold(0, (sum, item) => sum + item.quantity)}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 8),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // Add to cart
                Expanded(
                  child: SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _addToCart,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        _addedToCart ? 'Thêm một nữa' : 'Thêm vào giỏ hàng',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
