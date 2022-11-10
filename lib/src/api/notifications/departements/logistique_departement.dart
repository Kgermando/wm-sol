// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:get/get.dart';
import 'package:wm_solution/src/api/header_http.dart';
import 'package:wm_solution/src/api/route_api.dart';
import 'package:wm_solution/src/models/notify/notify_sum_model.dart';
import 'package:http/http.dart' as http;

class LogistiqueDepartementNotifyApi extends GetConnect {
  var client = http.Client();

  var logistiqueUrl = Uri.parse(
      "$logistiqueDepartementNotifyUrl/get-count-departement-logistique/");

  Future<NotifySumModel> getCountLogistique() async {
    Map<String, String> header = headers;

    var resp = await client.get(logistiqueUrl, headers: header);

    if (resp.statusCode == 200) {
      return NotifySumModel.fromJson(json.decode(resp.body));
    } else {
      throw Exception(resp.statusCode);
    }
  }
}

