import 'package:equatable/equatable.dart';
import 'package:myapp/utils/product.dart';

// Abstract class representing product-related events
abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => []; // Equatable props, used for comparison
}

// Event to load products
class LoadProducts extends ProductEvent {}

// Event to add a new product
class AddProduct extends ProductEvent {
  final Product product;

  const AddProduct(this.product);

  @override
  List<Object?> get props =>
      [product]; // Include product in props for comparison

  @override
  String toString() =>
      'AddProduct { product: $product }'; // String representation of the event
}

// Event to edit an existing product
class EditProduct extends ProductEvent {
  final Product product;

  const EditProduct(this.product);

  @override
  List<Object?> get props =>
      [product]; // Include product in props for comparison

  @override
  String toString() =>
      'EditProduct { product: $product }'; // String representation of the event
}

// Event to delete a product
class DeleteProduct extends ProductEvent {
  final Product product;

  const DeleteProduct(this.product);

  @override
  List<Object?> get props =>
      [product]; // Include product in props for comparison

  @override
  String toString() =>
      'DeleteProduct { product: $product }'; // String representation of the event
}

// Event to search products based on a query
class SearchProducts extends ProductEvent {
  final String query;

  SearchProducts(this.query);

  @override
  List<Object?> get props => [query]; // Include query in props for comparison
}
