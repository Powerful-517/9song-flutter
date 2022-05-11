import 'dart:convert';

import 'package:nine_song/models/auth_model.dart';
import 'package:nine_song/utils/http_request.dart';
import 'package:nine_song/config.dart';

class Auth {
  static Future<AuthAccessInfo?> postLoginInfo(String username, String password) async {
    var body = {
      "username": username,
      "password": password
    };
    return Request.httpPost(serverUrl + '/token/', body).then((response) {
      if (response.statusCode != 200) return null;
      var resultMap = jsonDecode(
        ascii.decode(response.bodyBytes),
      );
      return AuthAccessInfo.fromJson(resultMap);
    });
  }
}