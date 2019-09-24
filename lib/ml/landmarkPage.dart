import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';


class LandmarkPage extends StatefulWidget {
  @override
  _LandmarkPageState createState() => _LandmarkPageState();
}

class _LandmarkPageState extends State<LandmarkPage> {
  File _imageFile;
  VisionText _text;
  bool isLoading = false;
  ui.Image _image;

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
                    //child: CustomPaint(
                    //  painter: TextDetectorPainter(_image, _text),
                    //),
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
                    onPressed: () => {},
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