// Class representing a product
class Product {
   String itemName; // Name of the item
   String description; // Description of the item
   String material; // Material of the item

  // Constructor
  Product({
    required this.itemName,
    required this.description,
    required this.material,
  });

  // Factory method to create a Product object from JSON data
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      itemName: json['itemName'] ??
          '', // Assign itemName from JSON, defaulting to empty string if null
      description: json['description'] ??
          '', // Assign description from JSON, defaulting to empty string if null
      material: json['material'] ??
          '', // Assign material from JSON, defaulting to empty string if null
    );
  }

  // Method to convert Product object to JSON
  Map<String, dynamic> toJson() {
    return {
      'itemName': itemName, // Add itemName to JSON
      'description': description, // Add description to JSON
      'material': material, // Add material to JSON
    };
  }
}
