// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/product_class.dart';
import 'package:flutter_ecommerce/product_service.dart';
import 'package:flutter_ecommerce/screens/product_create.dart';
import 'package:flutter_ecommerce/screens/product_detail.dart';

void main() {
  runApp(const MyApp());
}

late List<Product> products;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Welcome to Flutter',
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Flutter'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return const ProductCreateScreen();
          }));
        },
      ),
      body: FutureBuilder<List<Product>>(
          future: getProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              products = snapshot.data!;
              return const HomeBody();
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
    );
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        products = await getProducts();
        setState(() {});
      },
      child: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: products.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (_, i) => Container(
          padding: const EdgeInsets.only(bottom: 32.0),
          child: productItem(products[i], context),
        ),
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
