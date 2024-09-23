import 'package:flutter/material.dart';
import 'package:market_place_flutter_e/pages/product_detail.dart';
import 'package:market_place_flutter_e/pages/add_product_page.dart';
import '../models/product_model.dart';
import '../components/item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> _products = products;

  void _addProduct(Product product) {
    setState(() {
      _products.add(product);
      _updateProductIds();
    });
  }

  void _removeProduct(int index) {
    setState(() {
      _products.removeAt(index);
      _updateProductIds();
    });
  }

  void _updateProductIds() {
    for (int i = 0; i < _products.length; i++) {
      _products[i].id = i + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text('Marketplace', style: TextStyle(color: Colors.black))),
      ),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductDetailPage(product: _products[index]),
                  ),
                );
              },
              child: Item(product: _products[index]),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _removeProduct(index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newProduct = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProductPage()),
          );
          if (newProduct != null) {
            _addProduct(newProduct);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}