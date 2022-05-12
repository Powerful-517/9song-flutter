import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:nine_song/utils/local_storage.dart';

class NetworkException implements Exception {
  final String? message;

  NetworkException([this.message]);

  @override
  String toString() {
    if (message == null) return "Network Exception";
    return "Network Exception: $message";
  }
}

class Request {
  static http.Client client = http.Client();

  static Map<String, String> getTokenHeaders() {
    var token = LocalStorage.getToken();
    Map<String, String> headers = {
      "Authorization": "Bearer $token"
    };
    return headers;
  }

  static Future<http.Response> httpGet(
      String url, Map<String, dynamic>? body) async {
    if (body == null) {
      return await client.get(Uri.parse(url), headers: getTokenHeaders());
    } else {
      var paramString = '?';
      body.forEach((k, v) {
        if (v != null) {
          paramString += k + '=' + v.toString() + '&';
        }
      });
      try {
        var result = await client.get(
          Uri.parse(url + paramString.substring(0, paramString.length - 1)),
          headers: getTokenHeaders()
        );
        return result;
      } catch (_) {
        throw NetworkException();
      }
    }
  }

  static Future<http.Response> httpPost(
      String url, Map<String, dynamic>? body) async {
    if (body == null) {
      try {
        var result = await client.post(Uri.parse(url), headers: getTokenHeaders());
        return result;
      } catch (_) {
        throw NetworkException();
      }
    } else {
      Map<String, dynamic> paramMap = {};
      body.forEach((k, v) {
        if (v != null) {
          paramMap[k] = v.toString();
        }
      });
      try {
        var result = await client.post(Uri.parse(url), body: paramMap);
        return result;
      } catch (_) {
        throw NetworkException();
      }
    }
  }

  static Future<http.Response> httpUpload(
      String url, Map<String, dynamic>? body, File file) async {
    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));
      request.headers['Authorization'] = "Bearer ${LocalStorage.getToken()}";
      if (body != null) {
        body.forEach((k, v) {
          if (v != null) {
            request.fields[k] = v.toString();
          }
        });
      }
      request.files.add(await http.MultipartFile.fromPath('file', file.path));
      var response = await request.send();
      return http.Response.fromStream(response);
    } catch (_) {
      throw NetworkException();
    }
  }
}
