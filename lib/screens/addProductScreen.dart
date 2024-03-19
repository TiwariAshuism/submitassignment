import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/bloc/product_bloc.dart';
import 'package:myapp/bloc/product_event.dart';
import 'package:myapp/utils/product.dart';

class AddProductScreen extends StatelessWidget {
  // Text editing controllers for item name, description, and material
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController materialController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text field for item name
            TextField(
              controller: itemNameController,
              decoration: InputDecoration(labelText: 'Item Name'),
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
            SizedBox(height: 20), // Spacer

            // Button to add product
            ElevatedButton(
              onPressed: () {
                // Create a new product object using the entered data
                final newProduct = Product(
                  itemName: itemNameController.text,
                  description: descriptionController.text,
                  material: materialController.text,
                );
                // Dispatch AddProduct event to the ProductBloc
                BlocProvider.of<ProductBloc>(context)
                    .add(AddProduct(newProduct));
                // Navigate back to the previous screen
                Navigator.pop(context);
              },
              child: Text('Add Product'), // Button text
            ),
          ],
        ),
      ),
    );
  }
}
