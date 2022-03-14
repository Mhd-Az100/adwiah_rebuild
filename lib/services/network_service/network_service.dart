import 'package:adwiah/constants/storage_constants.dart';
import 'package:adwiah/services/logging_service.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'api_exceptions.dart';

class NetworkService {
  static const String BASE_URL = "https://www.hippokrateways.com/";

  final _log = LogService();
  Map<String, String> _requestHeaders = {
    HttpHeaders.acceptHeader: "application/json",
    "X-Requested-With": "XMLHttpRequest"
  };

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await retry(
        () => http
            .get(Uri.parse(BASE_URL + url), headers: _requestHeaders)
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

  Future<dynamic> post({String? url, dynamic body}) async {
    // appendAPITokenToHeader();
    print("post $body");

    _log.wtf(BASE_URL + url!);
    var responseJson;
    try {
      final response = await http.post(Uri.parse(BASE_URL + url),
          body: json.encoder.convert(body),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json; charset=UTF-8'
          });
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
