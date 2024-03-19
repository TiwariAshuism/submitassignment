import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/utils/product.dart';
import 'package:myapp/screens/detailScreen.dart';
import 'package:myapp/screens/editProductScreen.dart';

import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import '../utils/carbonFactor.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late List<Product> _filteredProducts;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _filteredProducts = [];
    _searchController = TextEditingController();
    BlocProvider.of<ProductBloc>(context).add(LoadProducts());
  }

  // Search for products based on the entered value
  _searchProduct(value) {
    BlocProvider.of<ProductBloc>(context).add(SearchProducts(value));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('All Products'),
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProductsLoaded) {
              return Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  // Search bar
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        _searchProduct(value);
                      },
                      decoration: InputDecoration(
                        hintText: 'Search',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  // Bar chart displaying carbon footprint
                  if (state.products.isNotEmpty)
                    Container(
                      height: 200,
                      padding: EdgeInsets.all(16),
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: _calculateMaxY(state.products),
                          barTouchData: BarTouchData(enabled: false),
                          titlesData: FlTitlesData(
                            bottomTitles: SideTitles(
                              showTitles: true,
                              getTextStyles: (context, value) =>
                                  const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              getTitles: (value) {
                                if (value % 1 == 0) {
                                  return state.products[value.toInt()].itemName;
                                }
                                return '';
                              },
                              margin: 5,
                            ),
                            leftTitles: SideTitles(showTitles: false),
                            rightTitles: SideTitles(showTitles: false),
                          ),
                          gridData: FlGridData(show: false),
                          barGroups: _generateBarGroups(state.products),
                        ),
                      ),
                    ),
                  // List of products
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return ListTile(
                          title: Text(product.itemName),
                          subtitle: Text(product.description),
                          trailing: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditProductScreen(product: product),
                                ),
                              );
                            },
                          ),
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Delete Product'),
                                  content: Text(
                                      'Are you sure you want to delete ${product.itemName}?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        BlocProvider.of<ProductBloc>(context)
                                            .add(DeleteProduct(product));
                                        Navigator.pop(context);
                                      },
                                      child: Text('Delete'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailScreen(product: product),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return Container(); // Placeholder, can be replaced with appropriate error handling
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/addProduct');
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  // Calculate the maximum y-value for the bar chart
  double _calculateMaxY(List<Product> products) {
    double maxY = 0;
    for (var product in products) {
      double footprint = calculateCarbonFootprint(
          product.itemName, 5); //(product name, total weight)
      if (footprint > maxY) maxY = footprint;
    }
    return maxY;
  }

  // Generate bar chart groups
  List<BarChartGroupData> _generateBarGroups(List<Product> products) {
    List<BarChartGroupData> barGroups = [];
    for (int i = 0; i < products.length; i++) {
      final double footprint = calculateCarbonFootprint(
          products[i].itemName, 5); //(product name, total weight)
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              y: footprint,
              colors: [Colors.blue],
            ),
          ],
        ),
      );
    }
    return barGroups;
  }
}
