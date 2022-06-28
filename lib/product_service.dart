import 'package:flutter_ecommerce/product_class.dart';
import 'package:flutter_ecommerce/products_mock.dart';

Future<List<Product>> getProducts() => Future.delayed(
      const Duration(seconds: 2),
      () => productsMock,
    );
