import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../utils/app_fonts.dart';
import '../utils/app_function.dart';

class ApiManager {
  static Future<dynamic> callGet(
      {Map<String, String>? headers, endPoint,method,body}) async {
    bool isNet = await AppFunctions.checkInternet();
    if (isNet) {
      try {
        Map<String, dynamic> finalresponse;
        Uri url = Uri.parse(endPoint);
        http.Response response;
        switch (method.toUpperCase()) {
          case 'GET':
            response = await http.get(url);
            break;
          case 'POST':
            response = await http.post(url, headers: headers, body: jsonEncode(body));
            break;
          case 'PUT':
            response = await http.put(url, headers: headers, body: jsonEncode(body));
            break;
          default:
            return {'error': 'Invalid HTTP method'};
        }
        return checkResponse(response);
      } on SocketException catch (_) {
        throw Fonts.checkConnection.tr;
      }
    } else {
      throw Fonts.checkConnection.tr;
    }
  }
}

dynamic checkResponse(http.Response response) {
  if (response.statusCode == 200) {

    return response.body;
  } else if (response.statusCode == 401) {
    return response.body;
  } else if (response.statusCode == 404) {
    return response.body;
  } else if (response.statusCode == 409) {
    return response.body;
  } else if (response.statusCode == 500) {
    return response.body;
  } else {
    throw Fonts.errorMsg.tr;
  }
}
