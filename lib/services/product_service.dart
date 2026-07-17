import 'package:dio/dio.dart';
import '../models/product.dart';

class ProductService {
  final Dio _dio = Dio();

  static const String _url = 'https://accessories-eshop.runasp.net/api/products';

  Future<List<Product>> fetchProducts() async {
    final response = await _dio.get(_url);

    final data = response.data as Map<String, dynamic>;
    final items = data['items'] as List<dynamic>;

    return items
        .map((item) => Product.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
