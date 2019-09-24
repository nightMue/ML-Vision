import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';

class TextPage extends StatefulWidget {
  @override
  _TextPageState createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  File _imageFile;
  VisionText _text;
  bool isLoading = false;
  ui.Image _image;

   _getImageAndDetectText() async {
    final imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      isLoading = true;
    });
    final image = FirebaseVisionImage.fromFile(imageFile);
    final textDetector = FirebaseVision.instance.textRecognizer();
    final VisionText visionText = await textDetector.processImage(image);
    if (mounted) {
      setState(() {
        _imageFile = imageFile;
        _text = visionText;
        _loadImage(imageFile);
      });
    }
  }

  _loadImage(File file) async {
    final data = await file.readAsBytes();
    await decodeImageFromList(data).then(
      (value) => setState(() {
        _image = value;
        isLoading = false;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : (_imageFile == null)
              ? Center(child: Text('No image selected'))
              : Center(
                child: FittedBox(
                  child: SizedBox(
                    width: _image.width.toDouble(),
                    height: _image.height.toDouble(),
                    child: CustomPaint(
                      painter: TextDetectorPainter(_image, _text),
                    ),
                  ),
                ),
              ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FloatingActionButton(
                    heroTag: "btn1",
                    onPressed: () { Navigator.pop(context); },
                    tooltip: 'Back',
                    child: Icon(Icons.arrow_back),
                  ),
                  FloatingActionButton(
                    heroTag: 'btn2',
                    onPressed: _getImageAndDetectText,
                    tooltip: 'Pick Image',
                    child: Icon(Icons.add_a_photo),
                  ),
                ],
              ),
            )
          ],
        )
      );
  }
}

class TextDetectorPainter extends CustomPainter {
  final ui.Image image;
  final VisionText visionText;
  final List<Rect> rects = [];

  TextDetectorPainter(this.image, this.visionText) {
    for (var i = 0; i < visionText.blocks.length; i++) {
      rects.add(visionText.blocks[i].boundingBox);
    }
  }

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15.0
      ..color = Colors.yellow;

    canvas.drawImage(image, Offset.zero, Paint());
    for (var i = 0; i < visionText.blocks.length; i++) {
      canvas.drawRect(rects[i], paint);
    }
  }

  @override
  bool shouldRepaint(TextDetectorPainter oldDelegate) {
    return image != oldDelegate.image || visionText != oldDelegate.visionText;
  }
}
