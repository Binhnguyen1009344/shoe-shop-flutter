import 'shoe.dart';

class CartItem {
  final Shoe shoe;
  final String selectedSize;
  int quantity; // mutable — CartScreen sẽ tăng/giảm trực tiếp

  CartItem({
    required this.shoe,
    required this.selectedSize,
    this.quantity = 1,
  });

  double get totalPrice => shoe.price * quantity;
}
