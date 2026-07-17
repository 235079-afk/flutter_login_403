import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/product_service.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductService _productService;

  ProductCubit(this._productService) : super(const ProductInitial());

  Future<void> fetchProducts() async {
    emit(const ProductLoading());
    try {
      final products = await _productService.fetchProducts();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(const ProductError('Could not load products. Pull down to retry.'));
    }
  }
}
