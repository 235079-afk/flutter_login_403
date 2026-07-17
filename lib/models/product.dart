class Product {
  final String id;
  final String productCode;
  final String name;
  final String description;
  final String imageUrl;
  final double price;

  const Product({
    required this.id,
    required this.productCode,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String? ?? '',
      productCode: json['productCode'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      imageUrl: json['coverPictureUrl'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
