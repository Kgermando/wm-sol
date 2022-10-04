// import 'dart:convert';

// import 'package:get/get.dart';
// import 'package:localstorage/localstorage.dart'; 

// class LocalStorageData extends GetxController { 
//   static const _keyIdToken = 'idToken';
//   static const _keyAccessToken = 'accessToken';
//   static const _keyRefreshToken = 'refreshToken';

//   final LocalStorage storage = LocalStorage("wn_solution");

//   final _id = ''.obs;
//   String get id => _id.value;

//   final _token = ''.obs;
//   String get token => _token.value;

//   // ID User
//   getIdToken() async {
//     final data = await storage.getItem(_keyIdToken);
//     _id.value = data;
//   }

//   saveIdToken(value) async {
//     await storage.setItem(_keyIdToken, json.encode(value));
//   }

//   removeIdToken() async {
//     await storage.deleteItem(_keyIdToken); 
//   }

//   // AccessToken
//   getAccessToken() async { 
//     final data = await storage.getItem(_keyAccessToken);
//     _token.value = data;
//   }

//   saveAccessToken(value) async {
//     await storage.setItem(_keyAccessToken, json.encode(value)); 
//   }

//   removeAccessToken() async {
//     await storage.deleteItem(_keyAccessToken);
//   }

//   // RefreshToken
//   getRefreshToken() async {
//     final data = await storage.getItem(_keyRefreshToken);
//   }

//   saveRefreshToken(value) async {
//     await storage.setItem(_keyRefreshToken, json.encode(value));  
//   }

//   removeRefreshToken() async {
//     await storage.deleteItem(_keyRefreshToken); 
//   }
// }
