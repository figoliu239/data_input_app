import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'foodproduct.dart';
import 'secondPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Container(
            alignment: Alignment.center,
            child: Text('Error'),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              primarySwatch: Colors.blue,
            ),
            home: MyHomePage(title: 'Data Input Page'),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        );
      },
    );
  }


}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String mode = "total";
  final nameTextEditController = new TextEditingController();
  final categoryTextEditController = new TextEditingController();
  final volumeTextEditController = new TextEditingController();
  final energyTextEditController = new TextEditingController();
  final proteinTextEditController = new TextEditingController();
  final totalFatTextEditController = new TextEditingController();
  final saturatedFatTextEditController = new TextEditingController();
  final transFatTextEditController = new TextEditingController();
  final carbohydratesTextEditController = new TextEditingController();
  final dietarytFibreTextEditController = new TextEditingController();
  final sugarsTextEditController = new TextEditingController();
  final sodiumTextEditController = new TextEditingController();

  String submitName = "error";
  String submitCategory = "error";
  String submitVolume = "error";
  String submitEnergy = "error";
  String submitProtein = "error";
  String submitTotalFat = "error";
  String submitSaturatedFat = "error";
  String submitTransFat = "error";
  String submitCarbohydrates = "error";
  String submitDietaryFibre = "error";
  String submitSugars = "error";
  String submitSodium = "error";
  @override
  void initState() {
    super.initState();
  }

  void _changemode() {
    setState(() {
      if (mode == "total") {
        mode = "100";
      } else {
        mode = "total";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 44,
                child: Row(
                  children: [
                    Text("Mode:  " + mode),
                    SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: _changemode,
                      child: new Text('Change mode'),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.zero,
                height: 34.0,
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter product name.';
                    }
                    return null;
                  },
                  controller: nameTextEditController,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Product Name',
                    hintStyle: TextStyle(color: Colors.black, fontSize: 14),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 5.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 5.0),
                        borderRadius: BorderRadius.circular(14.0)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.zero,
                height: 34.0,
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter product category.';
                    }
                    return null;
                  },
                  controller: categoryTextEditController,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Product category',
                    hintStyle: TextStyle(color: Colors.black, fontSize: 14),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 5.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 5.0),
                        borderRadius: BorderRadius.circular(14.0)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.zero,
                height: 34.0,
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Volume.';
                    }
                    return null;
                  },
                  controller: volumeTextEditController,
                  keyboardType: TextInputType.number,
                  autofocus: false,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Product volume',
                    hintStyle: TextStyle(color: Colors.black, fontSize: 14),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 5.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 5.0),
                        borderRadius: BorderRadius.circular(14.0)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.zero,
                height: 34.0,
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter energy.';
                    }
                    return null;
                  },
                  controller: energyTextEditController,
                  keyboardType: TextInputType.number,
                  autofocus: false,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Product energy',
                    hintStyle: TextStyle(color: Colors.black, fontSize: 14),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 5.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 5.0),
                        borderRadius: BorderRadius.circular(14.0)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.zero,
                height: 34.0,
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter protein.';
                    }
                    return null;
                  },
                  controller: proteinTextEditController,
                  keyboardType: TextInputType.number,
                  autofocus: false,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Product protein',
                    hintStyle: TextStyle(color: Colors.black, fontSize: 14),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 5.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 5.0),
                        borderRadius: BorderRadius.circular(14.0)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.zero,
                height: 34.0,
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter totalFat.';
                    }
                    return null;
                  },
                  controller: totalFatTextEditController,
                  keyboardType: TextInputType.number,
                  autofocus: false,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Product totalFat',
                    hintStyle: TextStyle(color: Colors.black, fontSize: 14),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 5.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 5.0),
                        borderRadius: BorderRadius.circular(14.0)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.zero,
                height: 34.0,
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter saturatedFat.';
                    }
                    return null;
                  },
                  controller: saturatedFatTextEditController,
                  keyboardType: TextInputType.number,
                  autofocus: false,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Product saturatedFat',
                    hintStyle: TextStyle(color: Colors.black, fontSize: 14),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 5.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 5.0),
                        borderRadius: BorderRadius.circular(14.0)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.zero,
                height: 34.0,
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter transFat.';
                    }
                    return null;
                  },
                  controller: transFatTextEditController,
                  keyboardType: TextInputType.number,
                  autofocus: false,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Product transFat',
                    hintStyle: TextStyle(color: Colors.black, fontSize: 14),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 5.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 5.0),
                        borderRadius: BorderRadius.circular(14.0)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.zero,
                height: 34.0,
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter carbohydrates.';
                    }
                    return null;
                  },
                  controller: carbohydratesTextEditController,
                  keyboardType: TextInputType.number,
                  autofocus: false,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Product carbohydrates',
                    hintStyle: TextStyle(color: Colors.black, fontSize: 14),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 5.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 5.0),
                        borderRadius: BorderRadius.circular(14.0)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.zero,
                height: 34.0,
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter dietarytFibre.';
                    }
                    return null;
                  },
                  controller: dietarytFibreTextEditController,
                  keyboardType: TextInputType.number,
                  autofocus: false,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Product dietarytFibre',
                    hintStyle: TextStyle(color: Colors.black, fontSize: 14),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 5.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 5.0),
                        borderRadius: BorderRadius.circular(14.0)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.zero,
                height: 34.0,
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter sugars.';
                    }
                    return null;
                  },
                  controller: sugarsTextEditController,
                  keyboardType: TextInputType.number,
                  autofocus: false,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Product sugars',
                    hintStyle: TextStyle(color: Colors.black, fontSize: 14),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 5.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 5.0),
                        borderRadius: BorderRadius.circular(14.0)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.zero,
                height: 34.0,
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter sodium.';
                    }
                    return null;
                  },
                  controller: sodiumTextEditController,
                  keyboardType: TextInputType.number,
                  autofocus: false,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Product sodium',
                    hintStyle: TextStyle(color: Colors.black, fontSize: 14),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 5.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 5.0),
                        borderRadius: BorderRadius.circular(14.0)),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  print(mode);

                  submitName = nameTextEditController.text;
                  submitCategory = categoryTextEditController.text;
                  submitVolume = volumeTextEditController.text;
                  submitEnergy = energyTextEditController.text;
                  submitProtein = proteinTextEditController.text;
                  submitTotalFat = totalFatTextEditController.text;
                  submitSaturatedFat = saturatedFatTextEditController.text;
                  submitTransFat = transFatTextEditController.text;
                  submitCarbohydrates = carbohydratesTextEditController.text;
                  submitDietaryFibre = dietarytFibreTextEditController.text;
                  submitSugars = sugarsTextEditController.text;
                  submitSodium = sodiumTextEditController.text;

                  print("submitName: " + submitName);
                  print("submitCategory: " + submitCategory);
                  print("submitVolume: " + submitVolume);
                  print("submitEnergy: " + submitEnergy);
                  print("submitProtein: " + submitProtein);
                  print("submitTotalFat: " + submitTotalFat);
                  print("submitSaturatedFat: " + submitSaturatedFat);
                  print("submitTransFat: " + submitTransFat);
                  print("submitCarbohydrates: " + submitCarbohydrates);
                  print("submitDietaryFibre: " + submitDietaryFibre);
                  print("submitSugars: " + submitSugars);
                  print("submitSodium: " + submitSodium);
                  FoodProduct tempProduct = new FoodProduct();
                  if (mode == "total") {
                    tempProduct.name = submitName;
                    tempProduct.category = submitCategory;
                    tempProduct.volumeOrweight = double.parse(submitVolume);
                    tempProduct.energy = double.parse(submitEnergy);
                    tempProduct.protein = double.parse(submitProtein);
                    tempProduct.totalFat = double.parse(submitTotalFat);
                    tempProduct.saturatedFat = double.parse(submitSaturatedFat);
                    tempProduct.transFat = double.parse(submitTransFat);
                    tempProduct.carbohydrates =
                        double.parse(submitCarbohydrates);
                    tempProduct.dietarytFibre =
                        double.parse(submitDietaryFibre);
                    tempProduct.sugars = double.parse(submitSugars);
                    tempProduct.sodium = double.parse(submitSodium);
                  }
                  if (mode == "100") {
                    tempProduct.name = submitName;
                    tempProduct.category = submitCategory;
                    tempProduct.volumeOrweight = double.parse(submitVolume);
                    tempProduct.energy_100 = double.parse(submitEnergy);
                    tempProduct.protein_100 = double.parse(submitProtein);
                    tempProduct.totalFat_100 = double.parse(submitTotalFat);
                    tempProduct.saturatedFat_100 =
                        double.parse(submitSaturatedFat);
                    tempProduct.transFat_100 = double.parse(submitTransFat);
                    tempProduct.carbohydrates_100 =
                        double.parse(submitCarbohydrates);
                    tempProduct.dietarytFibre_100 =
                        double.parse(submitDietaryFibre);
                    tempProduct.sugars_100 = double.parse(submitSugars);
                    tempProduct.sodium_100 = double.parse(submitSodium);
                  }
                  tempProduct.calculateTotalNutrient();
                  tempProduct.printproduct();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SecondPage(
                            product: tempProduct,
                          )));
                },
                child: new Text('Next Page'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
