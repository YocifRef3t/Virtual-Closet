import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class APIHelper {
  Future<http.Response> post({
    required String url,
    @required dynamic body,
    String? token,
  }) async {
    Map<String, String>? headers =
        token != null ? {"Authorization": "Bearer $token"} : null;
    var response = await http.post(
      Uri.parse(url),
      body: body,
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<http.Response> get({
    required String url,
    String? token,
  }) async {
    Map<String, String>? headers =
        token != null ? {"Authorization": "Bearer $token"} : null;
    var response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception("Some thing went wrong");
    }
  }
}
