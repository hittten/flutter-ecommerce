import 'dart:convert';

import 'package:flutter_ecommerce/product_class.dart';
import 'package:http/http.dart' as http;

const apiUrl = 'https://us-central1-classroom-playground.cloudfunctions.net';
const user = 'gilberto';

Future<List<Product>> getProducts() async {
  final response = await http.get(Uri.parse('$apiUrl/products/$user'));

  if (response.statusCode == 200) {
    final List<dynamic> json = jsonDecode(response.body);

    return json.map((e) => Product.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load products');
  }
}

Future<Product> createProduct({
  required String name,
  required double price,
  required String description,
}) async {
  final response = await http.post(
    Uri.parse('$apiUrl/products/$user'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'name': name,
      'price': price,
      'description': description,
    }),
  );

  if (response.statusCode == 200) {
    return Product.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create produc.');
  }
}
