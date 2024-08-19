import 'package:flutter/material.dart';

import '../../../models/product_model/product_model.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;

  const ProductItem({
    super.key,
    required this.product,
  });

  String get _productPrice => '€${product.price}*';

  String get _buttonText =>
      product.isActive ? 'Add to shopping card' : 'Details';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Column(
        children: [
          Image.network(
            product.image,
          ),
          Row(
            children: [
              Flexible(
                child: Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 26,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Flexible(
                child: Text(
                  'Size: ${product.size}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(product.description),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                _productPrice,
                style: const TextStyle(
                  fontSize: 26,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                product.isActive ? Colors.blueAccent : Colors.white,
              ),
            ),
            onPressed: () {},
            child: Text(
              _buttonText,
              style: TextStyle(
                color: product.isActive ? Colors.white : Colors.grey,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
