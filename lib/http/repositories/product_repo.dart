import 'package:test_task_naghashyan/models/filter_model/filter_model.dart';
import 'package:test_task_naghashyan/models/response/meta.dart';

import '../../models/product_model/product_model.dart';
import '../../models/response/response.dart';
import '../dio.dart';

abstract class ProductRepository {
  Future<Response<List<ProductModel>>> getAllPaginated(FilterModel filter);
}

class ImplProductRepository extends ProductRepository {
  @override
  Future<Response<List<ProductModel>>> getAllPaginated(
    FilterModel filter,
  ) async {
    final res = await dio.post(
      '/product-listing/a515ae260223466f8e37471d279e6406',
      data: {
        "p": filter.page,
        "limit" : filter.limit,
      },
    );

    final productsJson = res.data['elements'] as List<dynamic>;

    List<ProductModel> products = [];
    for (final product in productsJson) {
      products.add(ProductModel.fromJson(product));
    }

    return Response<List<ProductModel>>(
      data: products,
      meta: Meta(
        page: res.data['page'],
        limit: res.data['limit'],
      ),
    );
  }
}
