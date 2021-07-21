import 'package:classify_cat_dog/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 10,
        navigateAfterSeconds: new Home(),
        title: new Text(
          'Classify Cat and Dog Application',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.deepOrange[60],
          ),
        ),
        image: new Image.asset('assets/icon.png'),
        backgroundColor: Colors.blueGrey[800],
        photoSize: 70,
        loaderColor: Colors.amberAccent);
  }
}
