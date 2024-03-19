import 'package:flutter/material.dart';
import 'package:myapp/utils/product.dart';

class DetailScreen extends StatelessWidget {
  final Product product; // Product object to display details for

  DetailScreen({required this.product}); // Constructor to initialize product

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'), // Title of the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display item name with bold font
            Text(
              'Item Name: ${product.itemName}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10), // Vertical spacing
            // Display description
            Text(
              'Description: ${product.description}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10), // Vertical spacing
            // Display material
            Text(
              'Material: ${product.material}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20), // Vertical spacing
            // Button to close the screen
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back to the previous screen
              },
              child: Text('Close'), // Button text
            ),
          ],
        ),
      ),
    );
  }
}
