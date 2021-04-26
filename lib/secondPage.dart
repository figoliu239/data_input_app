import 'package:data_input_app/foodproduct.dart';
import 'package:flutter/material.dart';
import 'foodproduct.dart';

class SecondPage extends StatefulWidget {
  SecondPage({
    Key key,
    @required this.product,
  }) : super(key: key);
  FoodProduct product;
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Page"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Text(widget.product.name),
        ),
      ),
    );
  }
}
