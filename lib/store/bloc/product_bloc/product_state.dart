import '../../../models/product_model/product_model.dart';

abstract interface class ProductState {}

class Loading extends ProductState {}

class BottomLoading extends ProductState {}

class LoadedProducts extends ProductState {
  final List<ProductModel> products;
  LoadedProducts({
    required this.products,
  });
}

class ProductsEmpty extends ProductState {}

class ProductsLoadFailure extends ProductState {
  final String message;

  ProductsLoadFailure(this.message);
}
