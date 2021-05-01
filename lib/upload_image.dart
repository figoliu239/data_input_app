import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:path/path.dart';
import 'foodproduct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadingImageToFirebaseStorage extends StatefulWidget {
  UploadingImageToFirebaseStorage({
    Key key,
    @required this.product,
    @required this.ingredient,
  }) : super(key: key);
  FoodProduct product;
  String ingredient;
  @override
  _UploadingImageToFirebaseStorageState createState() =>
      _UploadingImageToFirebaseStorageState();
}

class _UploadingImageToFirebaseStorageState
    extends State<UploadingImageToFirebaseStorage> {
  File _imageFile;

  ///NOTE: Only supported on Android & iOS
  ///Needs image_picker plugin {https://pub.dev/packages/image_picker}
  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

  Future uploadToFirebase(BuildContext context,FoodProduct product) async {
    product.calculateGrade();//calulate grade here, grade becomes not null
    String name=product.name;
    //todo:need barcode
    Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('productImage/'+name);
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    //String downloadURL = await FirebaseStorage.instance.ref('productImage/'+name).getDownloadURL(); this is working too
    String downloadURL = await taskSnapshot.ref.getDownloadURL();
    taskSnapshot.ref.getDownloadURL().then(
          (value) => print("Done: $value"),
    );
    FirebaseFirestore.instance.collection('foodProduct')
        .doc(product.name)
        .set({
      'name':product.name,
      'barcode':"null",
      'image':downloadURL,
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
      'grade':product.grade,
    }).then((value) => print("Uploaded")).catchError((onError) => print("Failed:" + onError));
    //String fileName = basename(_imageFile.path);

  }

  @override
  Widget build(BuildContext context) {
    FoodProduct product2 = widget.product;
    String ingredient = widget.ingredient;
    List<String> ingredientList = ingredient.split(",");
    product2.ingredients = ingredientList;
    return Scaffold(
      appBar: AppBar(
        title: Text("Camera page"),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 80),
        child: Center(
          child: Column(
            children: <Widget>[

              Expanded(
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: double.infinity,
                      margin: const EdgeInsets.only(
                          left: 30.0, right: 30.0, top: 10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: _imageFile != null
                            ? Image.file(_imageFile)
                            : ElevatedButton(
                          child: Icon(
                            Icons.add_a_photo,
                            size: 50,
                          ),
                          onPressed: pickImage,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => uploadToFirebase(context,product2),
                child: Text(
                  "Upload Image and product",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}