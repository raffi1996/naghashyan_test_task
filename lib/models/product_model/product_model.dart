
class ProductModel {
  String image;
  String name;
  String description;
  num price;
  bool isActive;
  DateTime createdAt;
  String size;

  ProductModel({
    required this.createdAt,
    this.image = '',
    this.name = '',
    this.description = '',
    this.price = 0,
    this.isActive = false,
    this.size = '',
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final productImageJson = json['media'] as List<dynamic>;
    final productNameJson = json['translated'];
    final sizeJson = json['options'] as List<dynamic>;

    final productImage = productImageJson.isNotEmpty
        ? productImageJson.first['media']['url']
        : '';
    final size = sizeJson.isNotEmpty ? sizeJson.first['name'] : '';

    final productName = productNameJson['name'];
    final productDescription = productNameJson['description'];
    final productPrice = json['calculatedPrice']['totalPrice'];
    final isActive = json['available'];
    final createdAt = DateTime.tryParse(json['createdAt']);


    return ProductModel(
      createdAt: createdAt!,
      image: productImage,
      name: productName,
      description: productDescription,
      price: productPrice,
      isActive: isActive,
      size: size,
    );
  }
}
