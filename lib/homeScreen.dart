import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = true;
  File _image;
  List _output;
  final picker = ImagePicker();

  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  detectImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.6,
        imageMean: 127.5,
        imageStd: 127.5);
    setState(() {
      _output = output;
      _loading = false;
    });
  }

  pickCameraImage() async {
    var image = await picker.getImage(source: ImageSource.camera);
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
    detectImage(_image);
  }

  pickGalleryImage() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
    detectImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Text(
              'Code Art',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            SizedBox(height: 10),
            Text(
              'Detect Cat and Dog',
              style: TextStyle(
                  color: Colors.amberAccent,
                  fontWeight: FontWeight.w500,
                  fontSize: 30),
            ),
            SizedBox(height: 30),
            Center(
              child: _loading
                  //if _loading is true ie no image selected or initial condition
                  ? Container(
                      width: 350,
                      child: Column(
                        children: [
                          Image.asset('assets/icon.png'),
                          SizedBox(height: 40),
                        ],
                      ),
                    )
                  //if _loading is set to false after selecting an image
                  : Container(
                      child: Column(
                        children: [
                          Container(
                            height: 250,
                            child: Image.file(_image),
                          ),
                          SizedBox(height: 20),
                          _output != null
                              ? Text(
                                  'It is a ${_output[0]['label']}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                )
                              : Container(
                                  width: 250,
                                  child: Text('Neither Cat nor Dog',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                )
                        ],
                      ),
                    ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      pickCameraImage();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width - 100,
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                      decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Click a Photo',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      pickGalleryImage();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width - 100,
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                      decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Select a Photo ',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
