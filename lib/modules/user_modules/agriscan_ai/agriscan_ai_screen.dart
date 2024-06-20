import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:image/image.dart' as img; // Add this dependency in pubspec.yaml
class AgriScanAiScreen extends StatefulWidget {
  const AgriScanAiScreen({Key? key}) : super(key: key);

  @override
  _AgriScanAiScreenState createState() => _AgriScanAiScreenState();
}

class _AgriScanAiScreenState extends State<AgriScanAiScreen> {
  File? _image;
  List<dynamic>? _results;
  bool _imageSelect = false;
  String? _resultText;
  double? _confidence;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<void> loadModel() async {
    Tflite.close();
    String? res = await Tflite.loadModel(
      model: 'assets/images/model_unquant.tflite',
      labels: 'assets/images/labels.txt',
    );
    print('Model loading status: $res');
  }

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      File image = File(pickedFile.path);
      if (containsGreen(image)) {
        await classifyImage(image);
      } else {
        setState(() {
          _image = image;
          _imageSelect = true;
          _resultText = "Photo doesn't contain a plant leaf";
          _confidence = 0;
        });
      }
    }
  }

  bool containsGreen(File image) {
    img.Image? originalImage = img.decodeImage(image.readAsBytesSync());
    if (originalImage == null) return false;

    int greenPixels = 0;
    int totalPixels = originalImage.width * originalImage.height;

    for (int y = 0; y < originalImage.height; y++) {
      for (int x = 0; x < originalImage.width; x++) {
        int pixel = originalImage.getPixel(x, y);
        int r = img.getRed(pixel);
        int g = img.getGreen(pixel);
        int b = img.getBlue(pixel);

        if (g > r && g > b && g > 100) { // Basic green color detection logic
          greenPixels++;
        }
      }
    }

    double greenRatio = greenPixels / totalPixels;
    print("Green ratio: $greenRatio");
    return greenRatio > 0.05;
  }

  Future<void> classifyImage(File image) async {
    final List<dynamic>? recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 1,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    if (recognitions != null && recognitions.isNotEmpty) {
      setState(() {
        _results = recognitions;
        _image = image;
        _imageSelect = true;
        _resultText = recognitions.first['label'];
        _confidence = recognitions.first['confidence'] * 100;
        if (_confidence! < 50) {
          _resultText = "Photo doesn't contain leaves";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Classification'),
      ),
      body: ListView(
        children: [
          _imageSelect
              ? Container(
            margin: const EdgeInsets.all(10),
            child: Image.file(_image!),
          )
              : Container(
            margin: const EdgeInsets.all(10),
            child: const Opacity(
              opacity: 0.8,
              child: Center(
                child: Text('No image selected'),
              ),
            ),
          ),
          if (_resultText != null)
            Card(
              child: Container(
                margin: const EdgeInsets.all(10),
                child: Text(
                  'Result: $_resultText\nConfidence: ${_confidence?.toStringAsFixed(2)}%',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickImage,
        tooltip: 'Pick Image',
       backgroundColor: Colors.green,
        child: const Icon(Icons.image),
      ),
    );
  }
}

