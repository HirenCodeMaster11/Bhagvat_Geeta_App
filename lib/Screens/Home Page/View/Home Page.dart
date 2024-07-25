import 'dart:ui';

import 'package:bhagvat_geeta_app/Screens/Home%20Page/provider/homeprovider.dart';
import 'package:bhagvat_geeta_app/Screens/Provider/gita%20provider.dart';
import 'package:bhagvat_geeta_app/utils/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    GitaProvider gitaProviderTrue = Provider.of<GitaProvider>(context,listen: true);
    GitaProvider gitaProviderFalse = Provider.of<GitaProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff5a3d20),
        leading: Icon(
          Icons.menu,
          size: 28,
          color: Colors.white,
        ),
        centerTitle: true,
        title: Text(
          'श्रीमद् भगवद्गीता',
          style: TextStyle(color: Colors.white, fontSize: w*0.07),
        ),
      ),
      body: Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.srgbToLinearGamma(),
            fit: BoxFit.cover,
            image: AssetImage('assets/images/splash.jpeg'),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 16,left: 14,right: 14,bottom: 16.0),
          child: ListView.builder(
            itemCount: 18,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                gitaProviderTrue.selectedIndex = index;
                Navigator.of(context).pushNamed('detail');
              },
              child: Card(
                color: Color.fromARGB(90, 224, 155, 60),
                child: ListTile(
                  leading: Text(
                    '${index+1}',style: TextStyle(fontWeight: FontWeight.w500,fontSize: w*0.054,color: Colors.white),),
                  title: Text(chap[index],style: TextStyle(fontWeight: FontWeight.w500,fontSize: w*0.062,color: Colors.white),),
                  subtitle: Text('अध्याय - ${index+1}   ${shlok[index]}',style: TextStyle(fontWeight: FontWeight.w500,fontSize: w*0.047,color: Colors.white),),
                  trailing: Icon(CupertinoIcons.right_chevron,size: w*0.06,color: Colors.white,)
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
