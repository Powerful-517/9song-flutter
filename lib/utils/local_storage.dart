import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage {
  static late Box _box;

  static Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox("nine_song_data_box");
  }

  static Future<void> clear() async {
    await _box.clear();
  }

  static dynamic _extract(dynamic key) {
    return _box.get(key);
  }

  static Future<void> _enter(dynamic key, dynamic value) async {
    return await _box.put(key, value);
  }

  static String? getToken() {
    return _extract("token");
  }

  static Future<void> setToken(String v) async {
    return await _enter("token", v);
  }

  static String? getUsername() {
    return _extract("username");
  }

  static Future<void> setUsername(String v) async {
    return await _enter("username", v);
  }

  static String? getNickname() {
    return _extract("nickname");
  }

  static Future<void> setNickname(String v) async {
    return await _enter("nickname", v);
  }
}
