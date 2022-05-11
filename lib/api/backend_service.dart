import 'dart:convert';

import 'package:nine_song/models/user_model.dart';
import 'package:nine_song/utils/http_request.dart';
import 'package:nine_song/config.dart';
import 'package:nine_song/utils/local_storage.dart';

class BackendService {
  static late String _token;
  static String get token => _token;

  static void loadToken() {
    if (LocalStorage.getToken() != null) {
      _token = LocalStorage.getToken()!;
    }
  }

  static Future<UserModel?> loginUser(String token) async {
    await LocalStorage.setToken(token);
    return Request.httpGet(serverUrl + '/users/', null).then((response) async {
      if (response.statusCode != 200) return null;
      Utf8Decoder utf8decoder = const Utf8Decoder();
      var resultMap = json.decode(
        utf8decoder.convert(response.bodyBytes),
      );
      var user = UserModel.fromJson(resultMap);
      await LocalStorage.setUsername(user.userName);
      await LocalStorage.setNickname(user.nickName);
      return user;
    });
  }
}
