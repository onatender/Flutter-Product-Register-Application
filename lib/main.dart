import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/product_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(home: ProductList());
  }
}
