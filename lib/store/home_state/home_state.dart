import 'package:mobx/mobx.dart';
import 'package:test_task_naghashyan/enums/sort_types.dart';
import 'package:test_task_naghashyan/models/filter_model/filter_model.dart';
import 'package:test_task_naghashyan/models/product_model/product_model.dart';
import 'package:test_task_naghashyan/store/loading_state/loading_state.dart';

import '../../http/repositories/product_repo.dart';

part 'home_state.g.dart';

class HomeState = _HomeState with _$HomeState;

abstract class _HomeState with Store {
  _HomeState({
    required this.productRepository,
  });

  final ProductRepository productRepository;
  final LoadingState loadingState = LoadingState();

  int page = 1;
  int limit = 3;
  bool hasNextPage = true;

  @observable
  bool hasScrollToggle = false;

  @observable
  ObservableList<ProductModel> products = <ProductModel>[].asObservable();

  @action
  Future<void> getProducts() async {
    if (hasNextPage && !loadingState.isLoading) {
      loadingState.startLoading();
      final res = await productRepository.getAllPaginated(FilterModel(page: page, limit: limit));
      page++;
      products.addAll(res.data);
      loadingState.stopLoading();
      if(res.data.isEmpty){
        hasNextPage = false;
      }
    }
  }



  void onTapSort(SortType type){
    switch(type){
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
        products.sort((a, b) => a.createdAt.millisecondsSinceEpoch.compareTo(b.createdAt.millisecondsSinceEpoch));
        break;
    }
  }



}
