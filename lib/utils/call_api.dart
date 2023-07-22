// File to call APIs

import 'dart:convert';
import 'dart:io';

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dating_made_better/global_store.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

const String baseURL = 'http://192.168.1.3:8080';
final _chuckerHttpClient = ChuckerHttpClient(http.Client());
final logger = Logger();

const httpCode = {"SUCCESS": 200};

const Map<String, String> defaultHeaders = {
  'Content-type': 'application/json',
  'Accept': 'application/json',
};

enum ApiType {
  sendOtp,
  verifyOtp,
  upsertUser,
}

const apiList = {
  ApiType.sendOtp: "/api/v1/user/send_otp",
  ApiType.verifyOtp: "/api/v1/user/verify_otp",
  ApiType.upsertUser: "/api/v1/user",
};

String getApiEndpoint(ApiType apiType) {
  return apiList[apiType]!;
}

Future<Map<String, dynamic>> callAPI(
  String reqUrl, {
  bodyParams = Null,
  // headers = defaultHeaders,
}) async {
  try {
    // logger.i("Logging", "Calling API: $reqUrl", bodyParams);
    final response = await _chuckerHttpClient.post(
      Uri.parse(baseURL + reqUrl),
      body: bodyParams,
      headers: {HttpHeaders.authorizationHeader: AppConstants.token},
    );
    if (response.statusCode != httpCode['SUCCESS']) {
      throw Exception('Failed to load data!, ${response.statusCode}');
    }
    final decodedResponse = jsonDecode(response.body);
    // logger.i(response.body);
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
  final data = await callAPI(getApiEndpoint(ApiType.verifyOtp), bodyParams: {
    'otp': otpEntered,
    'phone': phoneNumber,
  });
  AppConstants.token = data['authToken'];
}

Future<void> sendOtpApi(String phoneNumber) async {
  await callAPI(getApiEndpoint(ApiType.sendOtp), bodyParams: {
    'phone': phoneNumber,
  });
}

Future<void> upsertUserApi(Map<String, dynamic> bodyParams) async {
  await callAPI(getApiEndpoint(ApiType.upsertUser), bodyParams: bodyParams);
}
