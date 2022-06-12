import 'package:flutter/material.dart';
import 'package:flutter_sqflite_demo/data/dbHelper.dart';
import 'package:flutter_sqflite_demo/screens/product_add.dart';
import 'package:flutter_sqflite_demo/screens/product_detail.dart';
import '../models/product.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }

}

class _ProductListState extends State {
  var dbHelper = DbHelper();
  late List<Product> products;
  int productCount = 0;

  @override
  void initState() {
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ürün listesi"),
      ),
      body: buildProductList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goToProductAdd();
        },
        tooltip: "Yeni Ürün ekle",
        child: const Icon(Icons.add),
      ),
    );
  }

  ListView buildProductList() {
    return ListView.builder(
        itemCount: productCount,
        itemBuilder: (BuildContext context, int position) {
          // her dolaşmada bir return yapıp listeye atıyor.
          return Card(
            color: Colors.cyan,
            elevation: 2.0,
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.black12,
                child: Text("P"),
              ),
              title: Text(products[position].name),
              subtitle: Text(products[position].description),
              onTap: () {
                goToDetail(products[position]);
              },
            ),
          );
        }
    );
  }

  void goToProductAdd() async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ProductAdd()));
    // gerçekten ekleme yapıldıysa
    // ignore: unnecessary_null_comparison
    if (result != null) {
      if (result) {
        getProducts();
      }
    }
  }

  void getProducts() async {
    var productsFuture = dbHelper.getProducts();
    productsFuture.then((data) {
      products = data;
      productCount = data.length;
    });
  }

  void goToDetail(Product product) async {
    bool result = await Navigator.push( //Object yerine asıl kodda bool var.
        context, MaterialPageRoute(
        builder: (context) => ProductDetail(product)
    )
    );
    if (result != null) { // result null değilse
      if (result) { //result true ise
        getProducts();
      }
    }
  }
}