// File to call APIs

import 'dart:convert';
import 'dart:io';

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/global_store.dart';
import 'package:dating_made_better/models/chat.dart';
import 'package:dating_made_better/utils/internal_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

const String baseURL = 'http://192.168.1.5:8080';
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
  addActivity,
  getILiked,
  getLikedBy,
  getMatches,
  getThreads,
  getMessages,
  addMessage
}

const apiList = {
  ApiType.sendOtp: "/api/v1/user/send_otp",
  ApiType.verifyOtp: "/api/v1/user/verify_otp",
  ApiType.upsertUser: "/api/v1/user",
  ApiType.findStumbles: "/api/v1/activity/find",
  ApiType.addActivity: "/api/v1/activity",
  ApiType.getILiked: "/api/v1/activity?status=1",
  ApiType.getMatches: "/api/v1/activity?status=69",
  ApiType.getLikedBy: "/api/v1/activity/liked_by",
  ApiType.getThreads: "/api/v1/chat/threads",
  ApiType.getMessages: "/api/v1/chat",
  ApiType.addMessage: "/api/v1/chat",
};

String getApiEndpoint(ApiType apiType) {
  return apiList[apiType]!;
}

String getUrlFromQueryParams(queryParams) {
  queryParams ??= {};
  if (queryParams!.isEmpty) {
    return '';
  }
  String queryString =
      "?${queryParams.entries.map((e) => '${e.key}=${e.value}').join('&')}";
  return queryString;
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
            body: json.encode(bodyParams),
            headers: {
              HttpHeaders.authorizationHeader: AppConstants.token,
              HttpHeaders.contentTypeHeader: 'application/json',
            },
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

Future<dynamic> getUserApi() async {
  var authToken = await readSecureData(authKey);
  AppConstants.token = authToken ?? "";
  var data = await callAPI(getApiEndpoint(ApiType.upsertUser),
      method: HttpMethods.get);
  AppConstants.user = data;
  await writeSecureData("user", jsonEncode(data));
  return data;
}

Future<List<dynamic>> getPotentialStumblesApi() async {
  var data = await callAPI(getApiEndpoint(ApiType.findStumbles),
      method: HttpMethods.get);
  debugPrint(data.toString());
  return data["stumbles"];
}

Future<void> addActivityOnProfileApi(Map<String, dynamic> bodyParams) async {
  await callAPI(
    getApiEndpoint(ApiType.addActivity),
    method: HttpMethods.post,
    bodyParams: bodyParams,
  );
}

Future<List<dynamic>> getPeopleILiked() async {
  var data =
      await callAPI(getApiEndpoint(ApiType.getILiked), method: HttpMethods.get);
  debugPrint(data.toString());
  return data["activities"];
}

Future<List<dynamic>> getMatches() async {
  var data = await callAPI(getApiEndpoint(ApiType.getMatches),
      method: HttpMethods.get);
  debugPrint(data.toString());
  return data["activities"];
}

Future<List<dynamic>> getPeopleWhoLikedMe() async {
  var data = await callAPI(getApiEndpoint(ApiType.getLikedBy),
      method: HttpMethods.get);
  debugPrint(data.toString());
  return data["activities"];
}

Future<List<dynamic>> getThreads() async {
  var data = await callAPI(getApiEndpoint(ApiType.getThreads),
      method: HttpMethods.get);
  debugPrint(data.toString());
  return data["threads"];
}

Future<List<dynamic>> getChatMessages(String threadId) async {
  var data = await callAPI(getApiEndpoint(ApiType.getMessages),
      method: HttpMethods.get, queryParams: {"thread_id": threadId});
  debugPrint(data.toString());
  return data["messages"];
}

Future<ChatMessage> addChatMessage(
  String threadId,
  String message,
  int receiverId,
) async {
  var data = await callAPI(getApiEndpoint(ApiType.addMessage),
      method: HttpMethods.post,
      bodyParams: {
        'message': message,
        'threadId': threadId,
        'receiverId': receiverId
      });
  debugPrint(data.toString());
  return ChatMessage.fromJson(data["message"]);
}
