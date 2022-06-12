import 'package:flutter/material.dart';
import 'package:flutter_sqflite_demo/data/dbHelper.dart';
import '../models/product.dart';

class ProductDetail extends StatefulWidget {
  Product product;
  ProductDetail(this.product, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProductDetailState(product);
  }

}

class _ProductDetailState extends State{

  Product product;
  _ProductDetailState(this.product);
  var dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün Detayı : ${product.name}"),
        actions: <Widget>[
          PopupMenuButton<Options>(
            onSelected: selectProcess,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
              const PopupMenuItem<Options>(
                value: Options.delete,
                child: Text("Sil"),
              ),
              const PopupMenuItem<Options>(
                value: Options.update,
                child: Text("Güncelle"),
              ),
            ],
          ),
        ],
      ),
      body: buildProductDetail(),
      
    );
  }

  buildProductDetail() {
    
  }

  void selectProcess(Options options) async {
    switch(options){
      case Options.delete:
        await dbHelper.delete(product.id);
        Navigator.pop(context, true);
        break;
      default:
    }
  }
}

enum Options{delete, update}
