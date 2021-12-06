import 'package:flutter/material.dart';
import 'package:lang/model/verb.dart';
import 'package:lang/utils/connections.dart';
import "dart:async";
import 'package:flutter_tts/flutter_tts.dart';

class VerbProvider extends ChangeNotifier {
  DB db = DB();
  final FlutterTts tts = FlutterTts();
  int? _score;
  Color color = Colors.grey.shade200;
  bool isbusy = false;
  bool isRight = false;
  List<Verb> _verbs = [];
  List<Verb> get verbs {
    if (isRight) {
      _verbs.shuffle();
      isRight = false;
      color = Colors.grey.shade200;
      ChangeNotifier();
    }
    return _verbs;
  }

  setBusy(bool busy) {
    isbusy = busy;
    notifyListeners();
  }

  Future setVerbs() async {
    _verbs.clear();
    setBusy(true);
    await db.getVerbs().then((res) {
      for (var data in res) {
        _verbs.add(data);
      }
    });
    notifyListeners();
    setBusy(false);
  }

  Future update(Verb verb) async {
    setBusy(true);
    await db.db;
    await db.updateVerb(verb); //.then((value) => value);
    await setVerbs();
    notifyListeners();
    setBusy(false);
  }

  int? get score {
    db.db.then((value) => value);
    db.getCount().then((value) {
      _score = value;
    });
    notifyListeners();
    return _score;
  }

  speack(var text) async {
    tts.setLanguage('ru-RU');
    tts.setSpeechRate(0.3);
    tts.speak(text);
  }
}
