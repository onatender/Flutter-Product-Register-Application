import 'package:flutter/material.dart';
import 'package:flutter_application_2/data/dbHelper.dart';
import 'package:flutter_application_2/models/product.dart';
import 'package:flutter_application_2/screens/product_add.dart';
import 'package:flutter_application_2/screens/product_detail.dart';

class ProductList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }
}

class _ProductListState extends State {
  DbHelper dbHelper = new DbHelper();
  List<Product>? products;
  int productCount = 0;
  @override
  void initState() {
    getProducts();
    print(products?[0].name);
    print("calisti");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
        title: Text('Ürün Listesi'),
      ),
      body: buildProductList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          gotoProductAdd();
        },
        child: Icon(Icons.add),
        tooltip: "Yeni Ürün Ekle",
      ),
    );
  }

  ListView buildProductList() {
    print("pc $productCount");
    return ListView.builder(
      itemCount: productCount,
      itemBuilder: (BuildContext context, int position) {
        return Card(
            color: Colors.cyan,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                  backgroundColor: Colors.black12, child: Text("P")),
              title: Text(this.products![position].name),
              subtitle: Text(this.products![position].description),
              onTap: () {
                goToDetail(this.products![position]);
              },
            ));
      },
    );
  }

  void gotoProductAdd() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProductAdd()));
    if (result != null) {
      if (result) {
        getProducts();
      }
    }
  }

  void getProducts() async {
    var productsFuture = dbHelper.getProducts();
    productsFuture.then((data) {
      setState(() {
        this.products = data;
        productCount = data.length;
      });
    });
  }
  
  void goToDetail(Product product)  async{
    var result = await Navigator.push(context,MaterialPageRoute(builder: (context)=>ProductDetail(product)));
    if (result != null) {
      if (result) {
        getProducts();
      }
    }
  }
}
