import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';
import 'ocr_text_detail.dart';
import 'foodproduct.dart';
import 'upload_image.dart';
class OCRPage extends StatefulWidget {
  OCRPage({
    Key key,
    @required this.product,
  }) : super(key: key);
  FoodProduct product;
  @override
  _OCRPageState createState() => _OCRPageState();
}

class _OCRPageState extends State<OCRPage> {
  int _cameraOcr = FlutterMobileVision.CAMERA_BACK;
  bool _showTextOcr = true;
  Size _previewOcr;
  List<OcrText> _textsOcr = [];

  @override
  void initState() {
    super.initState();
    FlutterMobileVision.start().then((previewSizes) => setState(() {
          _previewOcr = previewSizes[_cameraOcr].first;
        }));
  }

  @override
  Widget build(BuildContext context) {
    FoodProduct product = widget.product;
    print(product.barcode);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        buttonColor: Colors.blue,
      ),
      home: DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              indicatorColor: Colors.black54,
              tabs: [Tab(text: "")],
            ),
            title: Text('OCR Page'),
          ),
          body: TabBarView(children: [
            _getOcrScreen(context,product),
          ]),
        ),
      ),
    );
  }

  Widget _getOcrScreen(BuildContext context, FoodProduct product) {
    List<Widget> items = [];
    items.add(
      Padding(
        padding: const EdgeInsets.only(
          left: 18.0,
          right: 18.0,
          bottom: 12.0,
        ),
        child: ElevatedButton(
          onPressed: _read,
          child: Text('Start OCR Scan'),
        ),
      ),
    );
    items.add(
      Padding(
        padding: const EdgeInsets.only(
          left: 18.0,
          right: 18.0,
          bottom: 12.0,
        ),
        child: ElevatedButton(
          onPressed: () {
            print(product.name);
            //print(_textsOcr[0].value);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UploadingImageToFirebaseStorage(
                      product: product,
                      ingredient:_textsOcr[0].value,
                      // ingredient:"water,juice",
                    )));
          },
          child: Text('Next Page'),
        ),
      ),
    );
    items.addAll(
      ListTile.divideTiles(
        context: context,
        tiles: _textsOcr
            .map(
              (ocrText) => OcrTextWidget(ocrText),
            )
            .toList(),
      ),
    );

    return ListView(
      padding: const EdgeInsets.only(
        top: 12.0,
      ),
      children: items,
    );
  }

  Future<Null> _read() async {
    List<OcrText> texts = [];
    List<OcrText> returntexts = [];
    try {
      texts = await FlutterMobileVision.read(
        flash: false,
        autoFocus: true,
        multiple: true,
        waitTap: true,
        showText: _showTextOcr,
        preview: _previewOcr,
        camera: _cameraOcr,
        fps: 0.05,
      );
    } on Exception {
      texts.add(OcrText('Failed to recognize text.'));
    }

    if (!mounted) return;
    for (var i = 0; i < texts.length; i++) {
      if (texts[i].value.contains("Ingredient")) {
        print(texts[i].value);
        String temp = texts[i].value.substring(
            texts[i].value.indexOf('Ingredient'), texts[i].value.length);
        // if(temp.contains(":")){temp=temp}
        returntexts.add(OcrText(temp));
        // returntexts[i].value.substring(returntexts[i].value.indexOf(':'),returntexts[i].value.length);
      }
    }
    if (returntexts.isEmpty){returntexts.add(OcrText('Failed to recognize the Ingredient List.'));}

    setState(() => _textsOcr = returntexts);
  }
}

class OcrTextWidget extends StatelessWidget {
  final OcrText ocrText;

  OcrTextWidget(this.ocrText);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.title),
      title: Text(ocrText.value),
      subtitle: Text(ocrText.language),
      trailing: const Icon(Icons.arrow_forward),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => OcrTextDetail(ocrText),
        ),
      ),
    );
  }
}
