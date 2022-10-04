import 'dart:convert';

import 'package:get_storage/get_storage.dart';

const _keyAccessToken = 'accessToken';
final box = GetStorage();
String accessToken = box.read(_keyAccessToken);

String token = jsonDecode(accessToken);

Map<String, String> headers = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  "authorization": "Bearer $token"
};
