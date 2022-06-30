import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/product_service.dart';
import 'package:flutter_ecommerce/screens/take_picture.dart';

class ProductCreateScreen extends StatefulWidget {
  const ProductCreateScreen({super.key});

  @override
  ProductCreateScreenState createState() {
    return ProductCreateScreenState();
  }
}

class ProductCreateScreenState extends State<ProductCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  XFile? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Create Product')),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          // Provide an onPressed callback.
          onPressed: () async {
            _image = await Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const TakePictureScreen()),
            );
            // List<int> imageBytes = _image.readAsBytes();
            // print(imageBytes);
            setState(() {});
          },
          child: const Icon(Icons.camera_alt),
        ),
        body: _form());
  }

  Form _form() {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildTextField('Name', _nameController),
              _buildTextField('Price', _priceController),
              _buildTextField('Description', _descriptionController),
              _buildField(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _image != null ? _boxPicture() : _emptyBoxPicture(),
                ],
              )),
              _buildField(
                  child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.

                    createProduct(
                      name: _nameController.text,
                      price: double.parse(_priceController.text),
                      description: _descriptionController.text,
                      image: _image!,
                    ).then((product) =>
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('${product.name} was created!')),
                        ));
                  }
                },
                child: const Text('Submit'),
              )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildField({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: child,
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return _buildField(
      child: TextFormField(
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          labelText: label,
        ),
        controller: controller,
      ),
    );
  }

  Widget _boxPicture() {
    return Image.file(
      File(_image!.path),
      fit: BoxFit.cover,
      height: 200,
    );
  }

  Widget _emptyBoxPicture() {
    return const SizedBox.square(
      dimension: 200,
      child: ColoredBox(
          color: Colors.white,
          child: Icon(
            Icons.image,
            color: Colors.grey,
          )),
    );
  }
}
