import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/views/signin.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  startSplashScreenTimer() async {
    var duration = new Duration(seconds: 5);
    return new Timer(duration, navigateToPage);
  }

  void navigateToPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SignIn(),
      ),
    );
  }
  @override
  void initState(){
    super.initState();
    startSplashScreenTimer();
  }

  @override
  Widget build(BuildContext context){
  SystemChrome.setEnabledSystemUIOverlays([]);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitHeight,
          image: ExactAssetImage("assets/splash.jpg"),
        ),
      ),
    );
  }
  @override
  void dispose(){
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }
}
