import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_input_app/foodproduct.dart';
import 'package:flutter/material.dart';
import 'foodproduct.dart';

class UploadPage extends StatefulWidget {
  UploadPage({
    Key key,
    @required this.product,
  }) : super(key: key);
  FoodProduct product;
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  @override
  Widget build(BuildContext context) {
    FoodProduct product2 = widget.product;
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload page"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text(product2.name),
              ElevatedButton(
                  child: new Text('Upload to firebase'),
                  onPressed: () {
                    uploadFoodProduct(product2);

                  })
            ],
          ),
        ),
      ),
    );
  }
  void uploadFoodProduct(FoodProduct product){
    FirebaseFirestore.instance.collection('foodProduct')
        .doc(product.name)
        .set({
      'name':product.name,
      'volumeOrweight':product.volumeOrweight,
      'category': product.category,
      'energy' : product.energy,
      'protein' : product.protein,
      'totalFat' : product.totalFat,
      'saturatedFat' : product.saturatedFat,
      'transFat' : product.transFat,
      'carbohydrates' : product.carbohydrates,
      'dietarytFibre' : product.dietarytFibre,
      'sugars' : product.sugars,
      'sodium' : product.sodium,
      'ingredients':product.ingredients,
      'star': 0,
    }).then((value) => print("Uploaded")).catchError((onError) => print("Failed:" + onError));
  }
}
