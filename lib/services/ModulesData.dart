import 'package:flutter/material.dart';

import '../models/transactions.dart';
import 'database/user_database_helper.dart';

class ModulesDataChangeNotifier extends ChangeNotifier {
  List<Map>? modulesData;
  Map? chaptersData;
  Map? questions;

  List<Map>? get getModules => modulesData;
  Map? get getChapters => chaptersData;
  Map? get getQuestions => questions;

  void setModules(List<Map> data) async {
    print('Setting Modules');
    modulesData = data;
    notifyListeners();
  }

  void setChapters(Map data) async {
    print('Setting Modules');
    chaptersData = data;
    notifyListeners();
  }

  void setQuestions(Map data) async {
    print('Setting Modules');
    questions = data;
    notifyListeners();
  }

  void setQuestionToAnswered(String moduleAndChapter, int index) async {
    print('Setting Modules');
    questions![moduleAndChapter][index]['unlocked'] = true;
    notifyListeners();
  }

  void unlockNextChapter(int chapterIndex, String moduleName) async {
    print('Setting Modules');
    chaptersData![moduleName][chapterIndex]['unlocked'] = true;
    notifyListeners();
  }
}

final modulesDataChangeNotifier = ModulesDataChangeNotifier();
