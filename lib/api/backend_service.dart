import 'dart:convert';

import 'package:nine_song/models/playlist_model.dart';
import 'package:nine_song/models/user_model.dart';
import 'package:nine_song/models/song_model.dart';
import 'package:nine_song/utils/http_request.dart';
import 'package:nine_song/config.dart';
import 'package:nine_song/utils/local_storage.dart';

class BackendService {
  static late String _token;
  static String get token => _token;
  static Utf8Decoder utf8decoder = const Utf8Decoder();

  static void loadToken() {
    if (LocalStorage.getToken() != null) {
      _token = LocalStorage.getToken()!;
    }
  }

  static Future<UserModel?> loginUser(String token) async {
    await LocalStorage.setToken(token);
    return Request.httpGet(serverUrl + '/users/', null).then((response) async {
      if (response.statusCode != 200) return null;
      var resultMap = json.decode(
        utf8decoder.convert(response.bodyBytes),
      );
      var user = UserModel.fromJson(resultMap);
      await LocalStorage.setUsername(user.userName);
      await LocalStorage.setNickname(user.nickName);
      return user;
    });
  }

  static Future<List<PlaylistModel>> getAllPlaylists() async {
    return Request.httpGet(serverUrl + '/playlists/', null)
        .then((response) async {
      if (response.statusCode != 200) return [];
      var resultList = json.decode(
        utf8decoder.convert(response.bodyBytes),
      ) as List;
      List<PlaylistModel> playlists = resultList
          .map((data) => PlaylistModel.fromJson(data))
          .toList();
      return playlists;
    });
  }

  static Future<UserModel?> getUserById(int id) async {
    return Request.httpGet(serverUrl + '/users/$id/', null)
        .then((response) async {
      if (response.statusCode != 200) return null;
      var resultMap = json.decode(
        utf8decoder.convert(response.bodyBytes),
      );
      UserModel user = UserModel.fromJson(resultMap);
      return user;
    });
  }

  static Future<SongModel?> getSongById(int id) async {
    return Request.httpGet(serverUrl + '/songs/$id', null)
        .then((response) async {
      if (response.statusCode != 200) return null;
      var resultMap = json.decode(
        utf8decoder.convert(response.bodyBytes),
      );
      SongModel song = SongModel.fromJson(resultMap);
      return song;
    });
  }
}
