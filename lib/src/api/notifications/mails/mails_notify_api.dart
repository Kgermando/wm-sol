// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:get/get.dart';
import 'package:wm_solution/src/api/header_http.dart';
import 'package:wm_solution/src/api/route_api.dart';
import 'package:wm_solution/src/models/notify/notify_model.dart';
import 'package:http/http.dart' as http;

class MailsNotifyApi extends GetConnect {
  var client = http.Client();

  Future<NotifyModel> getCount(String email) async {
    Map<String, String> header = headers;

    var getDDUrl = Uri.parse("$mailsNotifyUrl/get-count/$email");
    var resp = await client.get(getDDUrl, headers: header);

    if (resp.statusCode == 200) {
      return NotifyModel.fromJson(json.decode(resp.body));
    } else if (resp.statusCode == 401) {
      // await AuthApi().refreshAccessToken();
      return getCount(email);
    } else {
      throw Exception(resp.statusCode);
    }
  }
}
