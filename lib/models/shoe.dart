class Shoe {
  final String id;
  final String name;
  final String brand;
  final double price;
  final String description;
  final String imageUrl;
  final List<String> sizes;
  final String category;

  Shoe({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.sizes,
    required this.category,
  });
}

// ── Sample data ──────────────────────────────────────────────────────────────
final List<Shoe> sampleShoes = [
  Shoe(
    id: '1',
    name: 'Air Phantom',
    brand: 'Nike',
    price: 2499000,
    description:
        'Thiết kế tối giản, đế cao su chống trơn, phù hợp đi học và dạo phố hằng ngày.',
    imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600&q=80',
    sizes: ['38', '39', '40', '41', '42', '43'],
    category: 'Sneaker',
  ),
  Shoe(
    id: '2',
    name: 'Street Runner',
    brand: 'Adidas',
    price: 1899000,
    description:
        'Form giày thể thao cổ điển, đệm Cloudfoam êm ái, dễ phối đồ.',
    imageUrl: 'https://images.unsplash.com/photo-1608231387042-66d1773070a5?w=600&q=80',
    sizes: ['38', '39', '40', '41', '42'],
    category: 'Running',
  ),
  Shoe(
    id: '3',
    name: 'Mono Classic',
    brand: 'Vans',
    price: 1299000,
    description:
        'Phiên bản all-black tối giản, đế waffle bám đường, icon thời trang đường phố.',
    imageUrl: 'https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77?w=600&q=80',
    sizes: ['37', '38', '39', '40', '41'],
    category: 'Casual',
  ),
  Shoe(
    id: '4',
    name: 'Force Low',
    brand: 'Nike',
    price: 2199000,
    description:
        'Chất liệu da cao cấp, lót trong thoáng khí, đường may chắc chắn.',
    imageUrl: 'https://images.unsplash.com/photo-1600269452121-4f2416e55c28?w=600&q=80',
    sizes: ['39', '40', '41', '42', '43'],
    category: 'Sneaker',
  ),
  Shoe(
    id: '5',
    name: 'Boost Ultra',
    brand: 'Adidas',
    price: 2799000,
    description:
        'Công nghệ Boost hấp thụ lực tốt nhất, lý tưởng cho chạy bộ marathon.',
    imageUrl: 'https://images.unsplash.com/photo-1539185441755-769473a23570?w=600&q=80',
    sizes: ['40', '41', '42', '43', '44'],
    category: 'Running',
  ),
  Shoe(
    id: '6',
    name: 'Shadow Drift',
    brand: 'New Balance',
    price: 1699000,
    description:
        'Retro silhouette với phần đế chunky, trở lại mạnh mẽ trong xu hướng Y2K.',
    imageUrl: 'https://images.unsplash.com/photo-1556906781-9a412961d28d?w=600&q=80',
    sizes: ['38', '39', '40', '41', '42'],
    category: 'Lifestyle',
  ),
];
