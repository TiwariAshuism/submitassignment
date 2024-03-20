import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/bloc/product_bloc.dart';
import 'package:myapp/bloc/product_event.dart';
import 'package:myapp/utils/product.dart';

class AddProductScreen extends StatefulWidget {
  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  // Text editing controllers for item name, description, and material
  final TextEditingController itemNameController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController materialController = TextEditingController();

  String? _selectedItem;

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
          DropdownButton<String>(
          value: _selectedItem,
          onChanged: (String? newValue) {
            setState(() {
              _selectedItem = newValue;
            });
          },
          items: <String>[
            'electricity',
            'petrol',
            'diesel',
            'lpg',
            'other',
            // Add more items as needed
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          hint: Text('Select Item'),
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
                  itemName: _selectedItem.toString(),
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
