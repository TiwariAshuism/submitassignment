import 'package:equatable/equatable.dart';
import 'package:myapp/utils/product.dart';

// Abstract class representing different states of product-related operations
abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => []; // Equatable props, used for comparison
}

// State representing that products are being loaded
class ProductsLoading extends ProductState {}

// State representing that products have been loaded successfully
class ProductsLoaded extends ProductState {
  final List<Product> products; // List of loaded products

  const ProductsLoaded({required this.products});

  @override
  List<Object?> get props =>
      [products]; // Include products in props for comparison

  @override
  String toString() =>
      'ProductsLoaded { products: $products }'; // String representation of the state
}
