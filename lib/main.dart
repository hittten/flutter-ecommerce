// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/product_class.dart';
import 'package:flutter_ecommerce/product_service.dart';
import 'package:flutter_ecommerce/screens/product_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: FutureBuilder<List<Product>>(
            future: getProducts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final products = snapshot.data!;
                return ListView.separated(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: products.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (_, i) => Container(
                    padding: const EdgeInsets.only(bottom: 32.0),
                    child: productItem(products[i], context),
                  ),
                );
              } else if (snapshot.hasError) {
                return const Text('ERROR');
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    value: null,
                  ),
                );
              }
            }),
      ),
    );
  }
}

Column productItem(Product product, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Image.network(
        product.image,
        fit: BoxFit.fitWidth,
      ),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Text(
          product.name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Text('€ ${product.price.toStringAsFixed(2)}'),
      ElevatedButton(
        onPressed: () {
          _productDetails(product, context);
        },
        child: const Text('Details'),
      ),
    ],
  );
}

void _productDetails(Product product, BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return productDetailScreen(context, product);
  }));
}
