import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:bhagvat_geeta_app/utils/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_extend/share_extend.dart';

import '../../Provider/gita provider.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey imgKey = GlobalKey();

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    GitaProvider gitaProviderTrue =
        Provider.of<GitaProvider>(context, listen: true);
    GitaProvider gitaProviderFalse =
        Provider.of<GitaProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_outlined,
            size: 28,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xff5a3d20),
        centerTitle: true,
        title: Text(
          chap[gitaProviderTrue.selectedIndex],
          style: TextStyle(color: Colors.white, fontSize: w * 0.07),
        ),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              gitaProviderFalse.selectedLanguage(value);
            },
            icon: Icon(Icons.translate, color: Colors.white, size: 28),
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                value: 0,
                child: Text('Gujrati'),
              ),
              PopupMenuItem(
                value: 1,
                child: Text('Hindi'),
              ),
              PopupMenuItem(
                value: 2,
                child: Text('English'),
              ),
              PopupMenuItem(
                value: 3,
                child: Text('Sanskrit'),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.srgbToLinearGamma(),
            fit: BoxFit.cover,
            image: AssetImage('assets/images/splash.jpeg'),
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: PageView.builder(
                  itemCount: gitaProviderTrue
                      .gitaList[gitaProviderTrue.selectedIndex].Verses.length,
                  itemBuilder: (context, index) {
                    var verse = gitaProviderTrue
                        .gitaList[gitaProviderTrue.selectedIndex].Verses[index];
                    String displayText;
                    switch (gitaProviderTrue.selectedLan) {
                      case 0:
                        displayText = verse.language.Gujarati;
                        break;
                      case 1:
                        displayText = verse.language.Hindi;
                        break;
                      case 2:
                        displayText = verse.language.English;
                        break;
                      default:
                        displayText = verse.language.Sanskrit;
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          verse.language.Sanskrit,
                          style: TextStyle(
                              color: Colors.white, fontSize: w * 0.076),
                        ),
                        SizedBox(
                          height: h * 0.1,
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          displayText,
                          style: TextStyle(
                              color: Colors.white, fontSize: w * 0.076),
                        ),
                        SizedBox(
                          height: h * 0.06,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  builder: (context) => Dialog.fullscreen(
                                    backgroundColor: Colors.black,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: RepaintBoundary(
                                            key: imgKey,
                                            child: Container(
                                              height: double.infinity,
                                              width: double.infinity,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                fit: BoxFit.cover,
                                                colorFilter: ColorFilter
                                                    .srgbToLinearGamma(),
                                                image: AssetImage(
                                                    'assets/images/splash.jpeg'),
                                              )),
                                              child: BackdropFilter(
                                                filter: ImageFilter.blur(
                                                    sigmaY: 6, sigmaX: 6),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      '${verse.language.Sanskrit}',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: w * 0.076,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.1,
                                                    ),
                                                    Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      displayText,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: w * 0.076,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                RenderRepaintBoundary boundary =
                                                    imgKey.currentContext!
                                                            .findRenderObject()
                                                        as RenderRepaintBoundary;
                                                ui.Image image =
                                                    await boundary.toImage();
                                                ByteData? byteData =
                                                    await image.toByteData(
                                                        format: ui
                                                            .ImageByteFormat
                                                            .png);
                                                Uint8List img = byteData!.buffer
                                                    .asUint8List();
                                                ImageGallerySaver.saveImage(
                                                    img);
                                              },
                                              child: Container(
                                                height: h * 0.06,
                                                width: w * 0.4,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 1),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Icon(
                                                      Icons.save,
                                                      size: 35,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      'Save',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 24),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: w * 0.1,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                height: h * 0.06,
                                                width: w * 0.4,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    border: Border.all(
                                                        color: Colors.white,
                                                        width: 1)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Icon(
                                                      Icons.cancel,
                                                      size: 35,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 24),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.save,
                                size: w*0.1,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: w*0.07,),
                            IconButton(
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  builder: (context) => Dialog.fullscreen(
                                    backgroundColor: Colors.black,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: RepaintBoundary(
                                            key: imgKey,
                                            child: Container(
                                              height: double.infinity,
                                              width: double.infinity,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                fit: BoxFit.cover,
                                                colorFilter: ColorFilter
                                                    .srgbToLinearGamma(),
                                                image: AssetImage(
                                                    'assets/images/splash.jpeg'),
                                              )),
                                              child: BackdropFilter(
                                                filter: ImageFilter.blur(
                                                    sigmaY: 6, sigmaX: 6),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      '${verse.language.Sanskrit}',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: w * 0.076,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.1,
                                                    ),
                                                    Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      displayText,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: w * 0.076,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                RenderRepaintBoundary
                                                boundary = imgKey
                                                    .currentContext!
                                                    .findRenderObject()
                                                as RenderRepaintBoundary;
                                                ui.Image image =
                                                await boundary
                                                    .toImage();
                                                ByteData? byteData =
                                                await image.toByteData(
                                                    format: ui
                                                        .ImageByteFormat
                                                        .png);
                                                Uint8List img = byteData!
                                                    .buffer
                                                    .asUint8List();

                                                final path = await getApplicationCacheDirectory();
                                                final file = File(
                                                    "${path.path}/img.png");
                                                file.writeAsBytes(img);
                                                ShareExtend.share(
                                                    file.path, "image");
                                              },
                                              child: Container(
                                                height: h * 0.06,
                                                width: w * 0.4,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 1),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Icon(
                                                      Icons.share,
                                                      size: 35,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      'Share',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 24),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: w * 0.1,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                height: h * 0.06,
                                                width: w * 0.4,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    border: Border.all(
                                                        color: Colors.white,
                                                        width: 1)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Icon(
                                                      Icons.cancel,
                                                      size: 35,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 24),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.share,
                                size: w*0.1,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: w*0.07,),
                            IconButton(
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  builder: (context) => Dialog.fullscreen(
                                    backgroundColor: Colors.black,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: RepaintBoundary(
                                            key: imgKey,
                                            child: Container(
                                              height: double.infinity,
                                              width: double.infinity,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                fit: BoxFit.cover,
                                                colorFilter: ColorFilter
                                                    .srgbToLinearGamma(),
                                                image: AssetImage(
                                                    'assets/images/splash.jpeg'),
                                              )),
                                              child: BackdropFilter(
                                                filter: ImageFilter.blur(
                                                    sigmaY: 6, sigmaX: 6),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      '${verse.language.Sanskrit}',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: w * 0.076,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.1,
                                                    ),
                                                    Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      displayText,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: w * 0.076,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                RenderRepaintBoundary
                                                boundary = imgKey
                                                    .currentContext!
                                                    .findRenderObject()
                                                as RenderRepaintBoundary;
                                                ui.Image image =
                                                await boundary
                                                    .toImage();
                                                ByteData? byteData =
                                                await image.toByteData(
                                                    format: ui
                                                        .ImageByteFormat
                                                        .png);
                                                Uint8List img = byteData!
                                                    .buffer
                                                    .asUint8List();

                                                final path = await getApplicationCacheDirectory();
                                                final file = File(
                                                    "${path.path}/img.png");
                                                file.writeAsBytes(img);
                                                int location =WallpaperManager.BOTH_SCREEN;
                                                bool result = await WallpaperManager.setWallpaperFromFile(file.path, location);
                                              },
                                              child: Container(
                                                height: h * 0.06,
                                                width: w * 0.64,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 1),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Icon(
                                                      Icons.wallpaper,
                                                      size: 35,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      'Set as Wallpaper',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 24),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: w * 0.1,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                height: h * 0.06,
                                                width: w * 0.13,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    border: Border.all(
                                                        color: Colors.white,
                                                        width: 1),),
                                                child: Icon(
                                                  Icons.cancel,
                                                  size: 35,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.wallpaper,
                                size: w*0.1,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: w*0.07,),
                            IconButton(
                              onPressed: ()
                              {
                                Clipboard.setData(ClipboardData(text: displayText));
                              },
                              icon: Icon(
                                Icons.copy,
                                size: w*0.1,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
