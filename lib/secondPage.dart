import 'package:data_input_app/foodproduct.dart';
import 'package:flutter/material.dart';
import 'foodproduct.dart';
import 'thirdPage.dart';

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
    FoodProduct product2 = widget.product;
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Page(OCR)"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text(product2.name),
              ElevatedButton(
                  child: new Text('Next Page'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ThirdPage(
                                  product: product2,
                                )));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
