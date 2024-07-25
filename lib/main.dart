import 'package:bhagvat_geeta_app/Screens/Home%20Page/View/Home%20Page.dart';
import 'package:bhagvat_geeta_app/Screens/Home%20Page/provider/homeprovider.dart';
import 'package:bhagvat_geeta_app/Screens/Provider/gita%20provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Screens/Detail Screen/View/detail screen.dart';
import 'Screens/Splash Screen/Splash Screen.dart';

void main() {
  runApp(const BhagwatGitaApp());
}

class BhagwatGitaApp extends StatelessWidget {
  const BhagwatGitaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers:[
            ChangeNotifierProvider(create: (context) => GitaProvider(),),
          ],
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          // initialRoute: 'detail',
          routes: {
            '/' : (context) => SplashScreen(),
            'home' : (context) => HomePage(),
            'detail' : (context) => DetailScreen(),
          },
        ),
      );
  }
}
