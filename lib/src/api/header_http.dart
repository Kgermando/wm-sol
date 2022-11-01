import 'dart:convert';

import 'package:get_storage/get_storage.dart';


final box = GetStorage();
const _keyAccessToken = 'accessToken';

String? accessToken = box.read(_keyAccessToken);

String token = (accessToken == null) ? '' :  jsonDecode(accessToken!);

Map<String, String> headers = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  "Authorization": "Bearer $token"
};

Map<String, String> headerForm = {
  'Content-Type': 'multipart/form-data',
  'Authorization': 'Bearer $token'
};
