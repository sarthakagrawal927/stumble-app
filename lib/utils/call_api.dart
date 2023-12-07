// File to call APIs

import 'dart:convert';
import 'dart:io';

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/global_store.dart';
import 'package:dating_made_better/models/chat.dart';
import 'package:dating_made_better/providers/profile.dart';
import 'package:dating_made_better/utils/internal_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:http_parser/http_parser.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

const String baseURL = 'https://ipgtvmwff6.us-east-1.awsapprunner.com';
// local: http://192.168.1.4:8080
// prod: https://ipgtvmwff6.us-east-1.awsapprunner.com
final _chuckerHttpClient = ChuckerHttpClient(http.Client());
final logger = Logger();

final os = Platform.isAndroid ? '1' : '2';

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
  googleAuth,
  appleAuth,
  upsertUser,
  getProfile,
  findStumbles,
  addActivity,
  getILiked,
  getLikedBy,
  getMatches,
  getThreads,
  getMessages,
  startConversation,
  addMessage,
  uploadFile,
  activateUser,
  updateUserInterest,
  addDevice,
}

const apiList = {
  ApiType.sendOtp: "/api/v1/user/send_otp",
  ApiType.verifyOtp: "/api/v1/user/verify_otp",
  ApiType.googleAuth: "/api/v1/user/google_auth",
  ApiType.appleAuth: "/api/v1/user/apple_auth",
  ApiType.upsertUser: "/api/v1/user",
  ApiType.getProfile: "/api/v1/user?user_id=",
  ApiType.findStumbles: "/api/v1/activity/find",
  ApiType.addActivity: "/api/v1/activity",
  ApiType.getILiked: "/api/v1/activity?type=1",
  ApiType.getMatches: "/api/v1/activity?type=69",
  ApiType.getLikedBy: "/api/v1/activity/liked_by",
  ApiType.getThreads: "/api/v1/chat/threads",
  ApiType.getMessages: "/api/v1/chat",
  ApiType.addMessage: "/api/v1/chat",
  ApiType.startConversation: "/api/v1/chat/start_conversation",
  ApiType.uploadFile: "/api/v1/user/upload",
  ApiType.activateUser: "/api/v1/user/activate",
  ApiType.updateUserInterest: "/api/v1/activity/update_user_interest",
  ApiType.addDevice: "/api/v1/user/device",
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
            Uri.parse("$baseURL$reqUrl?os=$os"),
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
    final data = decodedResponse['data'] ?? {"": ""};
    return data;
  } catch (e) {
    debugPrint(e.toString());
    rethrow;
  } finally {
    _chuckerHttpClient.close();
  }
}

Future<Profile> verifyOtpApi(String otpEntered, String phoneNumber) async {
  final data = await callAPI(getApiEndpoint(ApiType.verifyOtp),
      bodyParams: {
        'otp': otpEntered,
        'phone': phoneNumber,
      },
      method: HttpMethods.post);
  AppConstants.token = data[authKey];
  AppConstants.user = data["user"];
  // add to storage
  await writeSecureData(authKey, AppConstants.token);
  return Profile.fromJson(data["user"]);
}

Future<Profile> verifyGoogleAuth(GoogleSignInAccount account) async {
  final authHeadersResult = await account.authHeaders;
  final authenticationResult = await account.authentication;

  final data = await callAPI(getApiEndpoint(ApiType.googleAuth),
      bodyParams: {
        'email': account.email,
        'id': account.id,
        'bearerToken': authHeadersResult["Authorization"],
      },
      method: HttpMethods.post);
  AppConstants.token = data[authKey];
  AppConstants.user = data["user"];
  // add to storage
  await writeSecureData(authKey, AppConstants.token);
  return Profile.fromJson(data["user"]);
}

Future<Profile> verifyAppleAuth(
    AuthorizationCredentialAppleID appleAuthId) async {
  final data = await callAPI(getApiEndpoint(ApiType.appleAuth),
      bodyParams: {
        "jwt": appleAuthId.identityToken,
        "userIdentifier": appleAuthId.userIdentifier,
        "authCode": appleAuthId.authorizationCode,
      },
      method: HttpMethods.post);
  AppConstants.token = data[authKey];
  AppConstants.user = data["user"];
  // add to storage
  await writeSecureData(authKey, AppConstants.token);
  return Profile.fromJson(data["user"]);
}

Future<void> sendOtpApi(String phoneNumber) async {
  await callAPI(getApiEndpoint(ApiType.sendOtp),
      bodyParams: {
        'phone': phoneNumber,
      },
      method: HttpMethods.post);
}

Future<Profile> upsertUserApi(Map<String, dynamic> bodyParams) async {
  try {
    var data = await callAPI(getApiEndpoint(ApiType.upsertUser),
        bodyParams: bodyParams, method: HttpMethods.post);
    AppConstants.user = data;
    return Profile.fromJson(data);
  } catch (err) {
    rethrow;
  }
}

Future<void> activateUserApi(Map<String, dynamic> bodyParams) async {
  await callAPI(getApiEndpoint(ApiType.activateUser),
      bodyParams: bodyParams, method: HttpMethods.post);
}

Future<bool> updateUserInterest(String threadId, int interest) async {
  try {
    var data = await callAPI(getApiEndpoint(ApiType.updateUserInterest),
        method: HttpMethods.post,
        bodyParams: {
          'threadId': threadId,
          'interest': interest,
        });
    return data["sameInterest"];
    // ignore: empty_catches
  } catch (error) {}
  return false;
}

Future<Profile?> getUserApi([int? profileId]) async {
  if (profileId == null) {
    var authToken = await readSecureData(authKey);
    AppConstants.token = authToken ?? "";
    if (AppConstants.token.isEmpty) {
      return null;
    }
  }
  var data = await callAPI(
    getApiEndpoint(ApiType.getProfile) +
        (profileId != null ? profileId.toString() : ""),
    method: HttpMethods.get,
  );

  if (profileId == null) {
    AppConstants.user = data;
    await writeSecureData("user", jsonEncode(data));
  }
  return Profile.fromJson(data);
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

Future<Map<String, dynamic>> getChatMessages(String threadId) async {
  var data = await callAPI(getApiEndpoint(ApiType.getMessages),
      method: HttpMethods.get, queryParams: {"thread_id": threadId});
  debugPrint(data.toString());
  return data;
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
  return ChatMessage.fromJson(data["message"]);
}

Future<ChatThread> startConversation(
  int receiverId,
) async {
  var data = await callAPI(getApiEndpoint(ApiType.startConversation),
      method: HttpMethods.post, bodyParams: {'receiverId': receiverId});

  return ChatThread.fromJson(data["thread"]);
}

Future<void> addDevice(String deviceToken) async {
  await callAPI(getApiEndpoint(ApiType.addDevice),
      method: HttpMethods.post, bodyParams: {'fcmToken': deviceToken});
}

Future<List<String>> uploadPhotosAPI(List<File> photos) async {
  try {
    FormData formData = FormData.fromMap({
      "photos": photos
          .map((e) => MultipartFile.fromFileSync(e.path,
              filename: e.path.split('/').last,
              contentType: MediaType('image', 'png')))
          .toList()
    });
    var dio = Dio();
    dio.options.headers["Authorization"] = AppConstants.token;
    dio.options.baseUrl = baseURL;

    var response =
        await dio.post(getApiEndpoint(ApiType.uploadFile), data: formData);
    final data = response.data["data"] as Map<String, dynamic>;
    return (data["filePaths"] as List<dynamic>).cast<String>();
  } catch (err) {
    debugPrint(err.toString());
    rethrow;
  }
}

/*
  * @description: Uploads photos to the server, unused
 */
Future<List<String>> uploadPhotosAPI2(List<File> photos) async {
  try {
    var httpMultipartRequest = http.MultipartRequest(
        "POST", Uri.parse(baseURL + getApiEndpoint(ApiType.uploadFile)));

    for (var photo in photos) {
      http.ByteStream byteStream = http.ByteStream((photo.openRead()));
      httpMultipartRequest.files.add(http.MultipartFile(
        'photos',
        byteStream,
        await photo.length(),
        filename: photo.path.split("/").last,
      ));
    }

    http.StreamedResponse response = await httpMultipartRequest.send();
    debugPrint(response.toString());

    response.stream.transform(utf8.decoder).listen((value) {
      debugPrint(value);
    });
  } catch (err) {
    debugPrint(err.toString());
  }
  return [""];
}
