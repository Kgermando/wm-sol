// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:get/get.dart';
import 'package:wm_solution/src/api/header_http.dart';
import 'package:wm_solution/src/api/route_api.dart';
import 'package:wm_solution/src/models/notify/notify_sum_model.dart';
import 'package:http/http.dart' as http;

class RhDepartementNotifyApi extends GetConnect {
  var client = http.Client();

  var rhUrl = Uri.parse("$rhDepartementNotifyUrl/get-count-departement-rh/");

  Future<NotifySumModel> getCountRh() async {
    Map<String, String> header = headers;

    var resp = await client.get(rhUrl, headers: header);

    if (resp.statusCode == 200) {
      return NotifySumModel.fromJson(json.decode(resp.body));
    } else {
      throw Exception(resp.statusCode);
    }
  }
}
