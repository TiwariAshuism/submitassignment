import 'package:flutter/material.dart';
import 'package:myapp/utils/carbonFactor.dart';
import 'package:myapp/utils/product.dart';

class DetailScreen extends StatefulWidget {
  final Product product; // Product object to display details for

  DetailScreen({required this.product});
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // Constructor to initialize product
  double _value = 0.0;
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
              'Item Name: ${widget.product.itemName}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10), // Vertical spacing
            // Display description
            Text(
              'Description: ${widget.product.description}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10), // Vertical spacing
            // Display material
            Text(
              'Material: ${widget.product.material}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20), // Vertical spacing
            // Button to close the screen
            Divider(
              height: 2,
            ),
            SizedBox(height: 20),
            Text(
              'Carbon Factor:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10), // Vertical spacing
            // Display description
            Slider(
              label: "weight",
              value: _value,
              min: 0.0,
              max: 100.0,
              onChanged: (double newValue) {
                setState(() {
                  _value = newValue;
                });
              },
            ),
            Text(
              'Weight: ${_value.toInt()} kg',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10), // Vertical spacing
            // Display description
            Text(
              'Total Carbon Emission: ${calculateCarbonFootprint(widget.product.itemName, _value).toInt()}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
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
