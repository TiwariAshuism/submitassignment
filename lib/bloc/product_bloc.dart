import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/bloc/product_event.dart';
import 'package:myapp/bloc/product_state.dart';
import 'package:myapp/utils/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductsLoading());

  List<Product> products = [];

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is LoadProducts) {
      yield* _mapLoadProductsToState();
    } else if (event is AddProduct) {
      _addProduct(event.product);
    } else if (event is EditProduct) {
      _editProduct(event.product);
    } else if (event is DeleteProduct) {
      _deleteProduct(event.product);
    } else if (event is SearchProducts) {
      yield* _mapSearchProductsToState(event.query);
    }
  }

  // Load products from shared preferences
  Stream<ProductState> _mapLoadProductsToState() async* {
    yield ProductsLoading();
    products = await _loadProductsFromPrefs();
    yield ProductsLoaded(products: List.of(products));
  }

  // Search products based on query
  Stream<ProductState> _mapSearchProductsToState(String query) async* {
    if (query.isEmpty) {
      yield ProductsLoaded(products: List.of(products));
    } else {
      List<Product> searchResults = products
          .where((product) =>
              product.itemName.toLowerCase().contains(query.toLowerCase()))
          .toList();
      yield ProductsLoaded(products: searchResults);
    }
  }

  // Load products from shared preferences
  Future<List<Product>> _loadProductsFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? productsJson = prefs.getString('products');
    if (productsJson != null) {
      Iterable decoded = jsonDecode(productsJson);
      List<Product> loadedProducts = List<Product>.from(
          decoded.map((productJson) => Product.fromJson(productJson)));
      return loadedProducts;
    }
    return [];
  }

  // Save products to shared preferences
  Future<void> _saveProductsToPrefs(List<Product> products) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String productsJson = json.encode(products
          .map<Map<String, dynamic>>((product) => product.toJson())
          .toList(),
    );
    await prefs.setString('products', productsJson);
  }

  // Add a new product
  void _addProduct(Product product) {
    products.add(product);
    _saveProductsToPrefs(products);
    add(LoadProducts());
  }

  // Edit an existing product
  void _editProduct(Product product) {
    int index = products.indexWhere((p) => p.itemName == product.itemName);
    if (index != -1) {
      print('Editing product: ${product.itemName}');
      products[index] = product;
      _saveProductsToPrefs(products);
      add(LoadProducts());
    }
  }

  // Delete a product
  void _deleteProduct(Product product) {
    products.removeWhere((p) => p.itemName == product.itemName);
    _saveProductsToPrefs(products);
    add(LoadProducts());
  }
}
