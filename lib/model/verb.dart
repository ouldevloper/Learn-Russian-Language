import 'package:intl/intl.dart';

class Verb {
  late var id;
  late var ru;
  late var en;
  late var points;
  late var lastupdate;

  Verb(
      {required this.id,
      required this.ru,
      required this.en,
      required this.points,
      required this.lastupdate});

  toMap() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd kk:mm:ss').format(now);
    Map<String, dynamic> map = {};
    map['id'] = id;
    map['ru'] = ru;
    map['en'] = en;
    map['points'] = points;
    map['last_update'] = formattedDate;
    return map;
  }

  Verb.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    ru = map['ru'];
    en = map['en'];
    points = map['poits'] ?? '0';
    lastupdate = map['last_update'];
  }

  isNotNull() {
    return !id.isNaN && ru.isNotEmpty && en.isNotEmpty && !points.isNotEmpty;
  }
}
