import 'package:flutter/cupertino.dart';

import 'custom_exception.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';

class APIManager {
  static const url = "http://localhost:4000/api/v1";
  Future<dynamic> postAPICall(String url, Map body) async {
    debugPrint("Calling API: $url");
    debugPrint("Calling parameters: $body");

    var responseJson;
    try {
      final response = await http.post(Uri.parse(url), body: body);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on HttpException {
      throw FetchDataException("Server not responding");
    } on TimeoutException {
      throw FetchDataException("Something went wrong");
    }
    return responseJson;
  }

  // create a get method
  Future<dynamic> getAPICall(String url) async {
    debugPrint("Calling API: $url");

    var responseJson;
    try {
      final response = await http.get(Uri.parse(url));
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on HttpException {
      throw FetchDataException("Server not responding");
    } on TimeoutException {
      throw FetchDataException("Something went wrong");
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        var responseJson = json.decode(response.body.toString());
        throw BadRequestException(responseJson['error']);
      case 401:
      case 403:
        var responseJson = json.decode(response.body.toString());
        throw UnauthorisedException(responseJson['error']);
      case 406:
        var responseJson = json.decode(response.body.toString());
        throw UnexceptedInputException(responseJson['error']);
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode: ${response.statusCode}');
    }
  }
}
