import 'dart:convert';

import 'package:flutter/services.dart';

class Localization {
  static Map<String, String> _localizedStrings = {};

  static Future<void> load() async {
    try {
      String jsonString =
          await rootBundle.loadString('assets/language/vi.json');
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      _localizedStrings = jsonMap.cast<String, String>();
    } catch (error) {
      print("Lỗi khi tải file JSON: $error");
    }
  }

  String stanslate(String key) {
    return _localizedStrings[key] ?? key;
  }
}
