import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../enums/sort_types.dart';
import '../../../http/repositories/product_repo.dart';
import '../../../models/filter_model/filter_model.dart';
import '../../../models/product_model/product_model.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  List<ProductModel> products = <ProductModel>[];

  final ProductRepository productsRepository;
  int page = 1;
  bool hasNextPage = true;

  ProductBloc(
    this.productsRepository,
  ) : super(Loading()) {
    on<GetProducts>(onGetProducts);

    on<OnSortTap>(onSortTap);
  }

  Future<void> onGetProducts(
    GetProducts event,
    Emitter<ProductState> emit,
  ) async {
    if (hasNextPage) {
      if (products.isEmpty) {
        emit(Loading());
      }

      final result = await productsRepository.getAllPaginated(
        QueryParams(page: page, limit: 3),
      );
      if (result.data.isEmpty) {
        hasNextPage = false;
      } else {
        page++;
      }
      products.addAll(result.data);
      emit(LoadedProducts(products: products));
    }
  }

  void onSortTap(OnSortTap event, Emitter<ProductState> emit) {
    switch (event.sortType) {
      case SortType.A_Z:
        products.sort((a, b) {
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        });
        break;
      case SortType.Z_A:
        products.sort((a, b) {
          return b.name.toLowerCase().compareTo(a.name.toLowerCase());
        });
        break;
      case SortType.PRICE_ASCENDING:
        products.sort((a, b) => b.price.compareTo(a.price));
        break;
      case SortType.PRICE_DESCENDING:
        products.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortType.LATEST:
        products.sort(
          (a, b) => a.createdAt.millisecondsSinceEpoch
              .compareTo(b.createdAt.millisecondsSinceEpoch),
        );
        break;
    }

    emit(LoadedProducts(products: products));
  }
}
