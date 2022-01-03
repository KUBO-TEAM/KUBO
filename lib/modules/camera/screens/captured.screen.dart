import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:tflite/tflite.dart';

class CapturedScreenArguments {
  final String imagePath;

  CapturedScreenArguments({required this.imagePath});
}

class CapturedScreen extends StatefulWidget {
  static const String id = 'captured_screen';
  const CapturedScreen({Key? key}) : super(key: key);

  @override
  State<CapturedScreen> createState() => _CapturedScreenState();
}

class _CapturedScreenState extends State<CapturedScreen> {
  List? _recognitions;
  File? _image;

  double _imageHeight = 0;
  double _imageWidth = 0;

  @override
  void initState() {
    super.initState();

    loadModel();
  }

  Future loadModel() async {
    Tflite.close();
    try {
      String? res = await Tflite.loadModel(
        model: "assets/models/yolov2_tiny_test.tflite",
        labels: "assets/models/yolov2_tiny.txt",
      );

      final args =
          ModalRoute.of(context)!.settings.arguments as CapturedScreenArguments;

      File image = File(args.imagePath);

      FileImage(image)
          .resolve(const ImageConfiguration())
          .addListener(ImageStreamListener((ImageInfo info, bool _) {
        setState(() {
          _imageHeight = info.image.height.toDouble();
          _imageWidth = info.image.width.toDouble();
        });
      }));

      await yolov2Tiny(image);

      setState(() {
        _image = image;
      });
    } on PlatformException {
      debugPrint('Failed to load model.');
    }
  }

  Future yolov2Tiny(File? image) async {
    int startTime = DateTime.now().millisecondsSinceEpoch;
    var recognitions = await Tflite.detectObjectOnImage(
      path: image!.path,
      model: "YOLO",
      threshold: 0.3,
      imageMean: 0.0,
      imageStd: 255.0,
      numResultsPerClass: 1,
    );

    setState(() {
      _recognitions = recognitions;
    });

    int endTime = DateTime.now().millisecondsSinceEpoch;
    debugPrint("Inference took ${endTime - startTime}ms");
  }

  List<Widget> renderBoxes(Size screen) {
    if (_recognitions == null) return [];
    if (_imageHeight == 0 || _imageWidth == 0) return [];

    double factorX = screen.width;
    double factorY = _imageHeight / _imageWidth * screen.width;
    Color blue = const Color.fromRGBO(37, 213, 253, 1.0);

    return _recognitions!.map((re) {
      return Positioned(
        left: re["rect"]["x"] * factorX,
        top: re["rect"]["y"] * factorY,
        width: re["rect"]["w"] * factorX,
        height: re["rect"]["h"] * factorY,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            border: Border.all(
              color: blue,
              width: 2,
            ),
          ),
          child: Text(
            "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
            style: TextStyle(
              background: Paint()..color = blue,
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stackChildren = [];
    Size size = MediaQuery.of(context).size;

    if (_recognitions != null && _image != null) {
      stackChildren.add(Positioned(
        top: 0.0,
        left: 0.0,
        width: size.width,
        child: Image.file(_image!),
      ));

      stackChildren.addAll(renderBoxes(size));

      return Scaffold(
        body: SafeArea(
          child: Stack(children: stackChildren),
        ),
      );
    }

    return Scaffold(
      body: Container(),
    );
  }
}
