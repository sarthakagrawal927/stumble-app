// File to call APIs

import 'dart:convert';
import 'dart:io';

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/global_store.dart';
import 'package:dating_made_better/utils/internal_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

const String baseURL = 'http://192.168.1.3:8080';
final _chuckerHttpClient = ChuckerHttpClient(http.Client());
final logger = Logger();

enum HttpMethods {
  post,
  get,
  put,
  delete,
}

const Map<String, String> defaultHeaders = {
  HttpHeaders.contentTypeHeader: 'application/json',
  HttpHeaders.acceptHeader: 'application/json',
};

enum ApiType {
  sendOtp,
  verifyOtp,
  upsertUser,
  findStumbles,
}

const apiList = {
  ApiType.sendOtp: "/api/v1/user/send_otp",
  ApiType.verifyOtp: "/api/v1/user/verify_otp",
  ApiType.upsertUser: "/api/v1/user",
  ApiType.findStumbles: "/api/v1/activity/find",
};

String getApiEndpoint(ApiType apiType) {
  return apiList[apiType]!;
}

String getUrlFromQueryParams(queryParams) {
  queryParams ??= {};
  if (queryParams!.isEmpty) {
    return '';
  }
  return "?${queryParams.entries.map((e) => '${e.key}=${e.value}').join('&')}";
}

Future<Map<String, dynamic>> callAPI(
  String reqUrl, {
  bodyParams = Null,
  queryParams,
  HttpMethods method = HttpMethods.get,
  headers = defaultHeaders,
}) async {
  try {
    final response = await (method == HttpMethods.post
        ? _chuckerHttpClient.post(
            Uri.parse(baseURL + reqUrl),
            body: bodyParams,
            headers: {HttpHeaders.authorizationHeader: AppConstants.token},
          )
        : _chuckerHttpClient.get(
            Uri.parse(baseURL + reqUrl + getUrlFromQueryParams(queryParams)),
            headers: {
              ...headers,
              HttpHeaders.authorizationHeader: AppConstants.token.isEmpty
                  ? await readSecureData(authKey) ?? ""
                  : AppConstants.token,
            },
          ));
    if (response.statusCode != HttpStatus.ok) {
      if (response.statusCode == HttpStatus.notFound) {
        // direct to login screen
      }
      throw Exception('Failed to load data!, ${response.statusCode}');
    }
    final decodedResponse = jsonDecode(response.body);
    logger.i(response.body);
    final data = decodedResponse['data'] as Map<String, dynamic>;
    return data;
  } catch (e) {
    debugPrint(e.toString());
    rethrow;
  } finally {
    _chuckerHttpClient.close();
  }
}

Future<void> verifyOtpApi(String otpEntered, String phoneNumber) async {
  final data = await callAPI(getApiEndpoint(ApiType.verifyOtp),
      bodyParams: {
        'otp': otpEntered,
        'phone': phoneNumber,
      },
      method: HttpMethods.post);
  AppConstants.token = data[authKey];
  // add to storage
  await writeSecureData(authKey, AppConstants.token);
}

Future<void> sendOtpApi(String phoneNumber) async {
  await callAPI(getApiEndpoint(ApiType.sendOtp),
      bodyParams: {
        'phone': phoneNumber,
      },
      method: HttpMethods.post);
}

Future<void> upsertUserApi(Map<String, dynamic> bodyParams) async {
  await callAPI(getApiEndpoint(ApiType.upsertUser),
      bodyParams: bodyParams, method: HttpMethods.post);
}

Future<void> getUserApi() async {
  var data = await callAPI(getApiEndpoint(ApiType.upsertUser),
      method: HttpMethods.get);
  AppConstants.user = data;
}

Future<List<dynamic>> getPotentialStumblesApi() async {
  var data = await callAPI(getApiEndpoint(ApiType.findStumbles),
      method: HttpMethods.get);
  debugPrint(data.toString());
  return data["stumbles"];
}
