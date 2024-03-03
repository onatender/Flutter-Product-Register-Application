import 'package:flutter/material.dart';
import 'package:flutter_application_2/data/dbHelper.dart';
import 'package:flutter_application_2/models/product.dart';

class ProductDetail extends StatefulWidget {
  Product product;
  ProductDetail(this.product);

  @override
  State<StatefulWidget> createState() {
    return _ProductDetailState(product);
  }
}

enum Options { delete, update }

class _ProductDetailState extends State {
  @override
  Product product;
  _ProductDetailState(this.product);
  DbHelper dbHelper = new DbHelper();
  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtUnitPrice = TextEditingController();

  @override
  void initState() {
    txtName.text = product.name;
    txtDescription.text = product.description;
    txtUnitPrice.text = product.unitPrice.toString();
  }
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Ürün Detayı : ${product.name}"),
          actions: [
            PopupMenuButton<Options>(
              onSelected: selectProcess,
              itemBuilder: (BuildContext context) => [
                PopupMenuItem<Options>(
                  value: Options.delete,
                  child: Text("Sil"),
                ),
                PopupMenuItem<Options>(
                  value: Options.update,
                  child: Text("Güncelle"),
                )
              ],
            )
          ],
        ),
        body: buildProductDetail());
  }

  buildProductDetail() {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Column(
        children: [
          buildNameField(),
          buildDescriptionField(),
          buildUnitPriceField(),
        ],
      ),
    );
  }

  void selectProcess(Options value) async {
    DbHelper dbHelper = new DbHelper();
    if (value == Options.delete) {
      await dbHelper.delete(product.id!);
      Navigator.pop(context, true);
    } else if (value == Options.update) {
      await dbHelper.update(Product.withId(id:product.id,name:txtName.text,description: txtDescription.text,unitPrice: double.tryParse(txtUnitPrice.text)));
      Navigator.pop(context,true);
    }
  }

  buildNameField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün Adı"),
      controller: txtName,
    );
  }

  buildDescriptionField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün Açıklaması"),
      controller: txtDescription,
    );
  }

  buildUnitPriceField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün Fiyatı"),
      controller: txtUnitPrice,
    );
  }
}
