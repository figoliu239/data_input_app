import 'package:data_input_app/foodproduct.dart';
import 'package:flutter/material.dart';
import 'foodproduct.dart';
import 'dart:io';
import 'thirdPage.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'upload_image.dart';

class SecondPage extends StatefulWidget {
  SecondPage({
    Key key,
    @required this.product,
    @required this.ingredient,
  }) : super(key: key);
  FoodProduct product;
  String ingredient;
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    FoodProduct product2 = widget.product;
    String ingredient = widget.ingredient;
    List<String> ingredient_list = ingredient.split(",");
    product2.ingredients = ingredient_list;
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Page"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                child: Text('Upload Image'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UploadingImageToFirebaseStorage(product:product2)
                          ));
                  }
              ),
              Text(product2.ingredients.last),
              ElevatedButton(
                  child: new Text('Next Page'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UploadPage(
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
