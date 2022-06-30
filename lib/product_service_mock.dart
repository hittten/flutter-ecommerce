import 'package:flutter_ecommerce/product_class.dart';
import 'package:flutter_ecommerce/products_mock.dart';

Future<List<Product>> getProducts() => Future.delayed(
      const Duration(seconds: 2),
      () => productsMock,
    );

Future<Product> createProduct({
  required String name,
  required double price,
  required String description,
}) async {
  await Future.delayed(const Duration(seconds: 2));

  final String id = (productsMock.length + 1).toString();

  final product = Product(
    id: id,
    name: name,
    price: price,
    description: description,
    image: 'https://picsum.photos/id/$id/680/460',
  );

  productsMock.insert(0, product);

  return product;
}
