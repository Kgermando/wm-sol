// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:get/get.dart';
import 'package:wm_solution/src/api/header_http.dart';
import 'package:wm_solution/src/api/route_api.dart';
import 'package:wm_solution/src/models/notify/notify_sum_model.dart';
import 'package:http/http.dart' as http;

class BudgetDepartementNotifyApi extends GetConnect {
  var client = http.Client();

  var budgetUrl =
      Uri.parse("$budgetsDepartementNotifyUrl/get-count-departement-budget/");

  Future<NotifySumModel> getCountBudget() async {
    Map<String, String> header = headers;

    var resp = await client.get(budgetUrl, headers: header);

    if (resp.statusCode == 200) {
      return NotifySumModel.fromJson(json.decode(resp.body));
    } else {
      throw Exception(resp.statusCode);
    }
  }
}
