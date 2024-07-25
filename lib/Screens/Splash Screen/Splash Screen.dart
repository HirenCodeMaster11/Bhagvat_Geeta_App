import 'dart:async';
import 'dart:ui';

import 'package:bhagvat_geeta_app/Screens/Home%20Page/View/Home%20Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    Timer(
      Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage(),
        ));
      },
    );
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.srgbToLinearGamma(),
            fit: BoxFit.cover,
            image: AssetImage('assets/images/splash.jpeg'),
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Center(
              child: Text(
            'श्रीमद् भगवद्गीता',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: w*0.12),
          )),
        ),
      ),
    );
  }
}
