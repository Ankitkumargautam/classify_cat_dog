import 'package:classify_cat_dog/splashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat and Dog Application',
      home: Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}
