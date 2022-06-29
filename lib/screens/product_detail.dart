import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/product_class.dart';

productDetailScreen(context, product) {
  return Scaffold(
    appBar: AppBar(title: const Text('Product Details')),
    body: _productDetailComponent(context, product),
  );
}

Column _buildButtonColumn(Color color, IconData icon, String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(icon, color: color),
      Container(
        margin: const EdgeInsets.only(top: 8),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
      ),
    ],
  );
}

_productDetailComponent(BuildContext context, Product product) {
  Widget titleSection = Container(
    padding: const EdgeInsets.all(32),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                '${product.price.toStringAsFixed(2)} €',
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
        Icon(
          Icons.star,
          color: Colors.red[500],
        ),
        const Text('41'),
      ],
    ),
  );

  Color color = Theme.of(context).primaryColor;

  Widget buttonSection = Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _buildButtonColumn(color, Icons.shopping_cart, 'ADD TO CART'),
      _buildButtonColumn(color, Icons.star_rate_sharp, 'RATE'),
      _buildButtonColumn(color, Icons.share, 'SHARE'),
    ],
  );

  Widget textSection = Padding(
    padding: const EdgeInsets.all(32),
    child: Text(
      product.description,
      softWrap: true,
    ),
  );

  return ListView(
    children: [
      Image.network(product.image),
      titleSection,
      buttonSection,
      textSection,
    ],
  );
}
