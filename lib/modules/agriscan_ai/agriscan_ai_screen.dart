import 'dart:io';
import 'package:agriscan/shared/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

import '../../shared/components/constants.dart';

class AgriScanAiScreen extends StatefulWidget {
  const AgriScanAiScreen({Key? key}) : super(key: key);

  @override
  _AgriScanAiScreenState createState() => _AgriScanAiScreenState();
}

class _AgriScanAiScreenState extends State<AgriScanAiScreen> {
  late File _image;
  late List<dynamic> _results;
  bool _imageSelect = false;

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
    print('Models loading status: $res');
  }

  Future<void> imageClassification(File image) async {
    final List<dynamic>? recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _results = recognitions!;
      _image = image;
      _imageSelect = true;
    });
  }

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    File image = File(pickedFile!.path);
    imageClassification(image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Classification',style: TextStyle(
          color:  kDarkGreenColor
        ),),
      ),
      body: ListView(
        children: [
          _imageSelect
              ? Container(
            margin: const EdgeInsets.all(10),
            child: Image.file(_image),
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
          SingleChildScrollView(
            child: Column(
              children: _imageSelect
                  ? _results.map((result) {
                return Card(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Text(
                      '${result['label']} - ${(result['confidence'] * 100).toStringAsFixed(1)}%',
                      style:  TextStyle(
                        color:  kDarkGreenColor,
                        fontSize: 20,
                      ),
                    ),
                  ),
                );
              }).toList()
                  : [],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:  kDarkGreenColor,
        onPressed: pickImage,
        tooltip: 'Pick Image',
        child: const Icon(Icons.image),
      ),
    );
  }
}