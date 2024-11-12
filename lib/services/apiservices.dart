import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smsseller/constants/appconstants.dart';
// import 'package:sms/constants/appconstants.dart';
// import 'package:sms/utiles.dart/apilogutlis.dart';
import 'package:smsseller/utiles.dart/apilogutlis.dart';

class HttpApiClient extends GetxService {
  final String _baseUrl = AppConstants.baseApiURL;

  String get baseUrl => _baseUrl;

  ///GET METHOD
  Future<http.Response> getFromServer({required String endPoint}) async {
    try {
      logData(message: 'Fetching All Data');
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      logData(message: "TOKEN is $token");

      final response = await http.get(Uri.parse('$baseUrl$endPoint'),
          headers: {'Authorization': 'Bearer $token'});

      logData(message: 'GET REQUEST: $baseUrl$endPoint');
      logData(message: 'RESPONSE BODY: ${response.body}');

      return response;
    } catch (e) {
      logData(message: "Exeption $e");
      rethrow;
    }
  }

  ///POST METHOD
  Future<http.Response> postToServer(
      {required String endPoint, required Map<String, dynamic>? data}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      final response = await http.post(
        Uri.parse('$baseUrl$endPoint'),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      logData(message: 'POST REQUEST: $baseUrl$endPoint');
      logData(message: 'REQUEST BODY: $data');
      logData(message: 'RESPONSE BODY: ${response.body}');
      return response;
    } catch (e) {
      logData(message: "Exeption $e");
      rethrow;
    }
  }

/////////post images methods
  Future<http.Response> postImagesToServer({
    required String endPoint,
    required Map<String, String> data,
    required Map<String, dynamic> files,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl$endPoint'),
      );

      request.headers['Authorization'] = 'Bearer $token';
      for (var entry in files.entries) {
        String key = entry.key;
        dynamic value = entry.value;

        if (value is List<File?>) {
          for (var file in value.where((file) => file != null).cast<File>()) {
            request.files
                .add(await http.MultipartFile.fromPath(key, file.path));
          }
        } else if (value is File?) {
          if (value != null) {
            request.files
                .add(await http.MultipartFile.fromPath(key, value.path));
          }
        }
      }

      request.fields.addAll(data);

      var response = await request.send();
      return http.Response.fromStream(response);
    } catch (e) {
      logData(message: "Exeption $e");
      rethrow;
    }
  }
}
