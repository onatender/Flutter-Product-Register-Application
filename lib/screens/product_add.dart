import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_2/data/dbHelper.dart';
import 'package:flutter_application_2/models/product.dart';

class ProductAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductAddState();
  }
}

class ProductAddState extends State {
  DbHelper dbHelper = new DbHelper();
  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtUnitPrice = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          foregroundColor: Colors.white,
          title: Text("Yeni Ürün Ekle"),
        ),
        body: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            children: [
              buildNameField(),
              buildDescriptionField(),
              buildUnitPriceField(),
              buildSaveButton()
            ],
          ),
        ));
  }
  
  buildNameField() {
    return TextField(
      decoration: InputDecoration(labelText:"Ürün Adı"),
      controller: txtName,
    );
  }
  
  buildDescriptionField() {return TextField(
      decoration: InputDecoration(labelText:"Ürün Açıklaması"),
      controller: txtDescription,
    );}
  
  buildUnitPriceField() {return TextField(
      decoration: InputDecoration(labelText:"Ürün Fiyatı"),
      controller: txtUnitPrice,
    );}
    buildSaveButton() {
      return ElevatedButton(onPressed: () {
        addProduct();
      }, child: Text("Ekle"));
    }
    
      void addProduct() async {
        await dbHelper.insert(Product(name:txtName.text,description:txtDescription.text,unitPrice:double.tryParse(txtUnitPrice.text)!));
        Navigator.pop(context,true);
      }
}
