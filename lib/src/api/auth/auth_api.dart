// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wm_solution/src/api/auth/api_error.dart';
import 'package:wm_solution/src/api/auth/token.dart';
import 'package:wm_solution/src/api/header_http.dart';
import 'package:wm_solution/src/api/route_api.dart';
import 'package:wm_solution/src/helpers/get_local_storage.dart';
import 'package:wm_solution/src/models/users/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:wm_solution/src/routes/routes.dart';

class AuthApi extends GetConnect {
  var client = http.Client();

  Future<bool> login(String matricule, String passwordHash) async {
    var data = {'matricule': matricule, 'passwordHash': passwordHash};
    var body = jsonEncode(data);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var resp = await client.post(loginUrl, body: body, headers: headers);
    if (resp.statusCode == 200) {
      GetStorage box = GetStorage(); 
      box.erase();

      Token token = Token.fromJson(json.decode(resp.body));
      // Store the tokens

      // box.write(_keyIdToken, json.encode(token.id.toString())); // Id user
      // box.write(_keyAccessToken, json.encode(token.accessToken)); // accessToken
      // box.write( _keyRefreshToken, json.encode(token.refreshToken)); // refreshToken
      GetLocalStorage().saveIdToken(token.id.toString()); // Id user
      GetLocalStorage().saveAccessToken(token.accessToken);
      GetLocalStorage().saveRefreshToken(token.refreshToken);
      return true;
    } else {
      // throw ApiError.fromJson(json.decode(resp.body));
      return false;
    }
  }

  // Future<bool> isLoggedIn() async {
  //   String? accessToken = await GetLocalStorage().getAccessToken();
  //   if (accessToken != null && accessToken.isNotEmpty) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  Future<void> refreshAccessToken() async {
    Map<String, String> header = headers;

    final box = GetStorage();
    String refreshTokenAccess = box.read('refreshToken');
    String refreshToken = jsonDecode(refreshTokenAccess);
    var data = {'refresh_token': refreshToken};
    var body = jsonEncode(data);
    var resp = await client.post(
      refreshTokenUrl,
      body: body,
      headers: header,
    );
    if (resp.statusCode == 200) { 
      Token token = Token.fromJson(json.decode(resp.body));
      GetLocalStorage().saveAccessToken(token.accessToken);
      GetLocalStorage().saveRefreshToken(token.refreshToken);
    } else {
      GetLocalStorage().removeAccessToken();
      GetLocalStorage().removeRefreshToken();
      throw ApiError.fromJson(json.decode(resp.body));
    }
  }

  // A timer to refresh the access token one minute before it expires
  refreshAccessTokenTimer(int time) async {
    var newTime = time - 60000; // Renew 1min before it expires
    await Future.delayed(Duration(milliseconds: newTime));

    try {
      await refreshAccessToken();
    } catch (e) {
      // await refreshAccessToken();
      refreshAccessTokenTimer(time);
      debugPrint('un soucis $e');
    }
  }

  Future<UserModel> getUserInfo() async {
    Map<String, String> header = headers;

    var resp = await client.get(userUrl, headers: header);
    if (resp.statusCode == 200) {
      return UserModel.fromJson(json.decode(resp.body));
    } else {
      throw Exception(json.decode(resp.body)['message']);
    }
  }

  Future<dynamic> getUserId() async {
    Map<String, String> header = headers;
    final box = GetStorage();

    String? idToken = box.read('idToken');
    int id = int.parse(jsonDecode(idToken!));
    if (kDebugMode) {
      print("getUserId: $id");
    }

    var userIdUrl = Uri.parse("$mainUrl/user/$id");
    var resp = await client.get(userIdUrl, headers: header);
    if (resp.statusCode == 200) {
      return UserModel.fromJson(json.decode(resp.body));
    } else if(resp.statusCode == 404) {
      GetStorage box = GetStorage();
      box.erase();
      return Get.offAllNamed(UserRoutes.login);
    } else {
      throw Exception(resp.statusCode);
    } 
  }

  // Future<UserModel> getUserId() async {
  //   Map<String, String> header = headers;
  //   final box = GetStorage();

  //   String? idToken = box.read('idToken');
  //   int id = (idToken == null) ? 0 : int.parse(jsonDecode(idToken));
  //   if (kDebugMode) {
  //     print("iddd: $id");
  //   }

  //   var userIdUrl = Uri.parse("$mainUrl/user/$id");
  //   var resp = await client.get(userIdUrl, headers: header);
  //   if (resp.statusCode == 200) {
  //     return UserModel.fromJson(json.decode(resp.body));
  //   } else if (resp.statusCode == 403) {
  //     return UserModel(
  //         nom: 'Error 403',
  //         prenom: 'Error 403',
  //         email: 'Error 403',
  //         telephone: 'Error 403',
  //         matricule: 'Error 403',
  //         departement: 'Support',
  //         servicesAffectation: 'Error 403',
  //         fonctionOccupe: 'Error 403',
  //         role: '5',
  //         isOnline: 'false',
  //         createdAt: DateTime.now(),
  //         passwordHash: 'Error 403',
  //         succursale: 'Error 403');
  //   } else if (resp.statusCode == 404) {
  //     return UserModel(
  //         nom: 'Error 404',
  //         prenom: 'Error 404',
  //         email: 'Error 404',
  //         telephone: 'Error 404',
  //         matricule: 'Error 404',
  //         departement: 'Support',
  //         servicesAffectation: 'Error 404',
  //         fonctionOccupe: 'Error 404',
  //         role: '5',
  //         isOnline: 'false',
  //         createdAt: DateTime.now(),
  //         passwordHash: 'Error 404',
  //         succursale: 'Error 404');
  //   } else {
  //     throw Exception(resp.statusCode);
  //   }
  // }

  Future<void> logout() async {
    Map<String, String> header = headers;
    try {
      var resp = await client.post(
        logoutUrl,
        headers: header,
      );
      if (resp.statusCode == 200) {}
    } catch (e) {
      throw Exception(['message']);
    }
  }
}
