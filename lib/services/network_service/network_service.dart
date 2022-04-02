import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:adwiah/Utils/storageController.dart';
import 'package:adwiah/services/logging_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';

import 'api_exceptions.dart';

class NetworkService {
  static const String BASE_URL = "https://www.hippokrateways.com/";
  final _log = LogService();

  // ignore: prefer_final_fields
  Map<String, String> _requestHeaders = {
    HttpHeaders.acceptHeader: "application/json",
    "X-Requested-With": "XMLHttpRequest"
  };
  final storage2 = FlutterSecureStorage();
  String Token = '';
  Future<dynamic> get({String? url, String? token}) async {
    Token = await storage2.read(key: 'token') ?? '';
    var responseJson;
    try {
      final response = await retry(
        () => http
            .get(Uri.parse(BASE_URL + url!),
                headers: token == null ? _requestHeaders : {'token': Token})
            .timeout(const Duration(seconds: 10)),
        retryIf: (error) =>
            error is SocketException || error is TimeoutException,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw TimeOutException('Connection timedout');
    }
    return responseJson;
  }

  Future<dynamic> post({String? url, dynamic body, String? token}) async {
    Token = await storage2.read(key: 'token') ?? '';
    print("post $body");

    _log.wtf(BASE_URL + url!);
    var responseJson;
    try {
      final response = await http.post(Uri.parse(BASE_URL + url),
          body: body,
          headers: token == null ? _requestHeaders : {'token': Token});
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw TimeOutException('Connection timedout');
    }

    return responseJson;
  }

  Future<dynamic> postwithtoken(String url, dynamic body) async {
    // appendAPITokenToHeader();
    print("post $body ");

    _log.wtf(BASE_URL + url);
    var responseJson;
    try {
      final response = await http.post(
        Uri.parse(BASE_URL + url),
        body: json.encoder.convert(body),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "X-Requested-With": "XMLHttpRequest"
        },
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw TimeOutException('Connection timedout');
    }

    return responseJson;
  }

  Future<dynamic> put(String url, Map body) async {
    // appendAPITokenToHeader();
    var responseJson;

    try {
      final response = await http.put(Uri.parse(BASE_URL + url), body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    // appendAPITokenToHeader();
    var apiResponse;
    try {
      final response = await http.delete(Uri.parse(BASE_URL + url));
      apiResponse = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return apiResponse;
  }

  dynamic _returnResponse(http.Response response) {
    _log.i(response.body.toString());
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 201:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  // void appendAPITokenToHeader() {
  //   String apiToken = _localStorageService.getFromDisk(API_TOKEN) ?? "";
  //   _requestHeaders[HttpHeaders.authorizationHeader] = "Bearer $apiToken";
  // }

  // String get getApiToken => _localStorageService.getFromDisk(API_TOKEN);

  // void _removeTokenFromHeader() {
  //   _requestHeaders.remove(HttpHeaders.authorizationHeader);
  // }
}
