import '../../models/filter_model/filter_model.dart';
import '../../models/product_model/product_model.dart';
import '../../models/response/meta.dart';
import '../../models/response/response.dart';
import '../dio.dart';

abstract class ProductRepository {
  Future<Response<List<ProductModel>>> getAllPaginated(QueryParams query);
}

class ImplProductRepository extends ProductRepository {
  @override
  Future<Response<List<ProductModel>>> getAllPaginated(
    QueryParams query,
  ) async {
    final res = await dio.post(
      '/product-listing/a515ae260223466f8e37471d279e6406',
      data: {
        'p': query.page,
        'limit': query.limit,
      },
    );

    final productsJson = res.data['elements'] as List<dynamic>;

    final products = <ProductModel>[];
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
