import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/bloc/product_bloc.dart';
import 'package:myapp/bloc/product_event.dart';

import '../utils/product.dart';

class EditProductScreen extends StatelessWidget {
  final Product product; // Product to be edited
  final TextEditingController
      itemNameController; // Controller for item name text field
  final TextEditingController
      descriptionController; // Controller for description text field
  final TextEditingController
      materialController; // Controller for material text field

  // Constructor to initialize the product and text editing controllers with the product details
  EditProductScreen({required this.product})
      : itemNameController = TextEditingController(text: product.itemName),
        descriptionController =
            TextEditingController(text: product.description),
        materialController = TextEditingController(text: product.material);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'), // Title of the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text field for item name
            TextField(
              controller: itemNameController,
              decoration: InputDecoration(labelText: 'Item Name (read Only)'),
              readOnly: true,
            ),
            // Text field for description
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            // Text field for material
            TextField(
              controller: materialController,
              decoration: InputDecoration(labelText: 'Material'),
            ),
            SizedBox(height: 20), // Vertical spacing
            // Button to save changes
            ElevatedButton(
              onPressed: () {
                // Create an edited product object with the new values
                final editedProduct = Product(
                  itemName: itemNameController.text,
                  description: descriptionController.text,
                  material: materialController.text,
                );
                // Dispatch EditProduct event to the ProductBloc
                BlocProvider.of<ProductBloc>(context)
                    .add(EditProduct(editedProduct));
                // Navigate back to the previous screen
                Navigator.pop(context);
              },
              child: Text('Save Changes'), // Button text
            ),
          ],
        ),
      ),
    );
  }
}
