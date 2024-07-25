import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Modal/gita modal.dart';

class GitaProvider extends ChangeNotifier
{
  List<GitaModal> gitaList = [];
  jsonParsing()
  async {
    String json = await rootBundle.loadString('assets/json/chapter.json');
    List gita = jsonDecode(json);
    gitaList = gita.map((e) => GitaModal.fromJson(e),).toList();
    notifyListeners();
  }
  int selectedIndex = 0;

  void selectedChap()
  {
    notifyListeners();
  }
  var selectedLan = 0;
  void selectedLanguage(int languageIndex)
  {
    selectedLan = languageIndex;
    notifyListeners();
  }
  GitaProvider()
  {
    jsonParsing();
  }
}